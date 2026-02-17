import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../product/constants/app_colors.dart';
import '../../../product/constants/app_dimensions.dart';
import '../../../product/utils/pick_files.dart';
import '../../../product/utils/show_error_message.dart';
import '../../../product/utils/show_loading_indicator.dart';
import '../../../product/utils/validators.dart';
import '../../widgets/app_button.dart';
import 'cubit/accident_cubit.dart';
import 'cubit/selected_files_cubit.dart';
import 'select_location_dialog.dart';

class NewAccidentScreen extends StatefulWidget {
  const NewAccidentScreen({Key? key}) : super(key: key);

  @override
  State<NewAccidentScreen> createState() => _NewAccidentScreenState();
}

class _NewAccidentScreenState extends State<NewAccidentScreen> {
  late TextEditingController _dateController;
  late TextEditingController _locationController;
  late TextEditingController _commentController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _dateController = TextEditingController();
    _locationController = TextEditingController();
    _commentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _locationController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: BlocListener<AccidentCubit, AccidentState>(
        listener: (context, state) {
          if (state is NewAccidentInProgress) {
            showLoadingIndicator(context);
          } else if (state is NewAccidentFailed) {
            context.pop();
            showErrorMessage(state.message);
          } else if (state is NewAccidentSuccess) {
            context.pop();
            showSuccessMessage(state.message);
          }
        },
        child: Column(
          children: [
            TextFormField(
              controller: _dateController,
              readOnly: true,
              onTap: () {
                showDatePicker(
                  context: context,
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now(),
                ).then((date) {
                  if (date != null) {
                    _dateController.text = DateFormat.yMd('tr').format(date);
                    context.read<AccidentCubit>().selectDate(date);
                  }
                });
              },
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: "Olayın Gerçekleşme Zamanı",
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              validator: (value) => Validators.cannotBlankValidator(value),
              controller: _locationController,
              decoration: InputDecoration(
                hintText: "Olayın Meydana Geldiği Yer",
                suffixIcon: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => SelectLocationDialog(
                        locationController: _locationController,
                      ),
                    ).whenComplete(
                      () {
                        if (context.read<AccidentCubit>().selectedLocation != null) {
                          _locationController.text = context.read<AccidentCubit>().locationText!;
                        }
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.location_searching,
                    color: AppColors.sunsetOrange,
                  ),
                ),
              ),
              maxLength: 250,
            ),
            TextFormField(
              validator: (value) => Validators.cannotBlankValidator(value),
              controller: _commentController,
              decoration: InputDecoration(
                hintText: "Olayın Açıklaması ve İyileştirme Öneriniz",
                suffixIcon: IconButton(
                  onPressed: () {
                    pickFiles().then(
                      (value) {
                        value.fold(
                          (l) => showErrorMessage(l.message),
                          (files) {
                            if (files != null) {
                              context.read<SelectedFilesCubit>().addFile(files);
                            }
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.attach_file,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              maxLines: 5,
              maxLength: 2000,
            ),
            context.watch<SelectedFilesCubit>().state.files.isNotEmpty
                ? SizedBox(
                    height: 50,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        context.read<SelectedFilesCubit>().state.files.length,
                        (index) {
                          final file = context.read<SelectedFilesCubit>().state.files[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.file_copy_outlined,
                                  color: Theme.of(context).primaryColor.withOpacity(0.7),
                                ),
                                Text(file.name),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(height: AppDimensions.mediumGap),
            AppButton(
              text: 'Formu Gönder',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<AccidentCubit>().newAccident(
                        context.read<AccidentCubit>().selectedDate!,
                        _commentController.text,
                        context.read<AccidentCubit>().selectedLocation!,
                        context.read<SelectedFilesCubit>().state.files,
                      );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
