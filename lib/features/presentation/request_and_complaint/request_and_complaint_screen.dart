import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../product/constants/app_dimensions.dart';
import '../../../product/constants/app_strings.dart';
import '../../../product/utils/network_manager.dart';
import '../../../product/utils/show_error_message.dart';
import '../../../product/utils/show_loading_indicator.dart';
import '../../../product/utils/validators.dart';
import '../../widgets/app_button.dart';
import '../../widgets/text_field_with_border.dart';
import 'cubit/request_and_complaint_cubit.dart';

class RequestAndComplaintScreen extends StatefulWidget {
  const RequestAndComplaintScreen({Key? key}) : super(key: key);

  @override
  State<RequestAndComplaintScreen> createState() => _RequestAndComplaintScreenState();
}

class _RequestAndComplaintScreenState extends State<RequestAndComplaintScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestAndComplaintCubit(NetworkManager(Dio())),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.requestAndComplaint),
        ),
        body: BlocConsumer<RequestAndComplaintCubit, RequestAndComplaintState>(
          listener: (context, state) {
            if (state is RequestAndComplaintLoading) {
              showLoadingIndicator(context);
            } else if (state is RequestAndComplaintFailed) {
              context.pop();
              showErrorMessage(state.message);
            } else if (state is RequestAndComplaintSuccess) {
              context.pop();
              showSuccessMessage(state.message);
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: AppDimensions.pagePadding,
                child: Column(
                  children: [
                    TextFieldWithBorder(
                      controller: _titleController,
                      maxLength: 250,
                      hintText: 'Konu Başlığı',
                      validator: (value) => Validators.cannotBlankValidator(value),
                    ),
                    const SizedBox(height: AppDimensions.mediumGap),
                    TextFieldWithBorder(
                      controller: _contentController,
                      hintText: 'İçerik',
                      maxLines: 5,
                      maxLength: 2000,
                      validator: (value) => Validators.cannotBlankValidator(value),
                    ),
                    const SizedBox(height: AppDimensions.mediumGap),
                    AppButton(
                      text: 'Formu Gönder',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<RequestAndComplaintCubit>().newRequest(
                                _titleController.text,
                                _contentController.text,
                              );
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
