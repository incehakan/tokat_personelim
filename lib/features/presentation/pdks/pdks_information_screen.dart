import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../product/constants/app_colors.dart';
import '../../../product/constants/app_dimensions.dart';
import '../../../product/utils/dependency_injection.dart';
import '../../../product/utils/open_map.dart';
import '../../data/models/pdks_information_model.dart';
import '../../widgets/app_button.dart';
import '../../widgets/custom_error_text.dart';
import '../../widgets/employee_information_card.dart';
import '../../widgets/info_screen_header.dart';
import '../../widgets/loading_indicator.dart';
import 'cubit/pdks_info_cubit.dart';

class PdksInformationScreen extends StatefulWidget {
  const PdksInformationScreen({Key? key}) : super(key: key);

  @override
  State<PdksInformationScreen> createState() => _PdksInformationScreenState();
}

class _PdksInformationScreenState extends State<PdksInformationScreen> {
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    _startDateController = TextEditingController(
      text: DateFormat.yMd('tr').format(
        DateTime.now().subtract(const Duration(days: 15)),
      ),
    );
    _endDateController = TextEditingController(
      text: DateFormat.yMd('tr').format(DateTime.now()),
    );
    super.initState();
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDKS İşlemlerim'),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<PdksInfoCubit>()
          ..getInformations(
            _startDateController.text,
            _endDateController.text,
          ),
        child: SingleChildScrollView(
          child: Padding(
            padding: AppDimensions.pagePadding,
            child: Column(
              children: [
                const EmployeeInformationCard(),
                const SizedBox(height: AppDimensions.mediumGap),
                DateSection(
                  startDateController: _startDateController,
                  endDateController: _endDateController,
                ),
                const SizedBox(height: AppDimensions.mediumGap),
                InfoSection(
                  startDateController: _startDateController,
                  endDateController: _endDateController,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateSection extends StatelessWidget {
  const DateSection({
    Key? key,
    required this.startDateController,
    required this.endDateController,
  }) : super(key: key);

  final TextEditingController startDateController;
  final TextEditingController endDateController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DatePickerWidget(
          controller: startDateController,
          title: 'Başlangıç Tarihi',
          onTap: () => context.read<PdksInfoCubit>().getInformations(
                startDateController.text,
                endDateController.text,
              ),
        ),
        const SizedBox(width: 10),
        DatePickerWidget(
          controller: endDateController,
          title: 'Bitiş Tarihi',
          onTap: () => context.read<PdksInfoCubit>().getInformations(
                startDateController.text,
                endDateController.text,
              ),
        ),
      ],
    );
  }
}

class InfoSection extends StatelessWidget {
  const InfoSection({
    Key? key,
    required this.startDateController,
    required this.endDateController,
  }) : super(key: key);

  final TextEditingController startDateController;
  final TextEditingController endDateController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PdksInfoCubit, PdksInfoState>(
      builder: (context, state) {
        if (state is PdksInfoSuccess) {
          return Column(
            children: [
              const InfoScreenHeader(text: 'PDKS Bilgilerim'),
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  state.informations.first.tarihler!.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: AppDimensions.smallGap),
                    child: InfoTile(informations: state.informations, index: index),
                  ),
                ),
              ),
            ],
          );
        } else if (state is PdksInfoFailed) {
          return CustomErrorText(message: state.message);
        } else {
          return const Center(
            child: CustomLoadingIndicator(),
          );
        }
      },
    );
  }
}

class InfoTile extends StatelessWidget {
  const InfoTile({
    Key? key,
    required this.informations,
    required this.index,
  }) : super(key: key);

  final List<PdksInformation> informations;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppDimensions.buttonRadius,
      child: ExpansionTile(
        backgroundColor: AppColors.spindle,
        collapsedBackgroundColor: AppColors.spindle,
        expandedAlignment: Alignment.topLeft,
        title: Text(
          DateFormat.yMd('tr').format(informations.first.tarihler![index].tarih!),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.kashmirBlue,
              ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.mediumGap),
            child: Column(
              children: [
                for (int i = 0; i < informations.first.tarihler!.first.detaylar!.length; i++)
                  Column(
                    children: [
                      Row(
                        children: [
                          informations.first.tarihler![index].detaylar![i].kolonAdi.toString() == "Görevlendirme"
                              ? const Text(
                                  "Görevlendirme:",
                                  style: TextStyle(
                                    color: AppColors.riverBed,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : const Text(
                                  "Giriş Zamanı:\nÇıkış Zamanı:",
                                  style: TextStyle(
                                    color: AppColors.riverBed,
                                  ),
                                ),
                          const SizedBox(width: AppDimensions.smallGap),
                          Text(
                            informations.first.tarihler![index].detaylar![i].kolonDeger.toString().trim(),
                            style: const TextStyle(
                              color: AppColors.riverBed,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.smallGap),
                      informations.first.tarihler![index].detaylar![i].kolonAdi.toString() == "Görevlendirme"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: AppButton(
                                    text: 'Başlangıç',
                                    onPressed: () {
                                      if (informations.first.tarihler![index].detaylar![i].basKoordinatX != null) {
                                        openMap(
                                          informations.first.tarihler![index].detaylar![i].basKoordinatX!,
                                          informations.first.tarihler![index].detaylar![i].basKoordinatY!,
                                        );
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: AppButton(
                                    text: 'Bitiş',
                                    onPressed: () {
                                      if (informations.first.tarihler![index].detaylar![i].bitKoordinatX != null) {
                                        openMap(
                                          informations.first.tarihler![index].detaylar![i].bitKoordinatX!,
                                          informations.first.tarihler![index].detaylar![i].bitKoordinatY!,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    Key? key,
    required this.controller,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: AppDimensions.pd12,
        decoration: const BoxDecoration(
          color: AppColors.kashmirBlue,
          borderRadius: AppDimensions.buttonRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
            TextField(
              textAlign: TextAlign.center,
              controller: controller,
              style: const TextStyle(
                color: Colors.white,
              ),
              onTap: () {
                showDatePicker(
                  context: context,
                  firstDate: DateTime.now().subtract(
                    const Duration(days: 10000),
                  ),
                  lastDate: DateTime.now().add(
                    const Duration(days: 30),
                  ),
                ).then((value) {
                  if (value != null) {
                    controller.text = DateFormat.yMd('tr').format(value);
                    onTap();
                  }
                });
              },
              readOnly: true,
              decoration: InputDecoration(
                hintText: title,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
