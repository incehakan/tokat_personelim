import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../product/constants/app_colors.dart';
import '../../../../../product/constants/app_dimensions.dart';
import '../../../../../product/constants/app_strings.dart';
import '../../../../../product/utils/dependency_injection.dart';
import '../../../../../product/utils/show_error_message.dart';
import '../../../../data/models/kiosk_model.dart';
import '../../../../data/repository/cache_repository.dart';
import '../../../../data/repository/hospital_repository.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/custom_error_text.dart';
import '../../../../widgets/info_card_template.dart';
import '../../../../widgets/loading_indicator.dart';
import 'cubit/make_appointment_cubit.dart';

class MakeAppointmentScreen extends StatefulWidget {
  const MakeAppointmentScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MakeAppointmentScreen> createState() => _MakeAppointmentScreenState();
}

class _MakeAppointmentScreenState extends State<MakeAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<MakeAppointmentCubit>()
        ..getKiosks(
          CacheRepository.getPatientRegistryNo(),
        ),
      child: Padding(
        padding: AppDimensions.pagePadding,
        child: BlocConsumer<MakeAppointmentCubit, MakeAppointmentState>(
          listener: (context, state) {
            if (state is AcceptanceControlFailed) {
              showDialog(
                context: context,
                builder: (ctx) => AppointmentFailedDialog(message: state.message),
              );
            } else if (state is AcceptanceControlSuccess) {
              showDialog(
                context: context,
                builder: (ctx) => AppointmentSuccessDialog(
                  policlinicName: state.policlinicName,
                  policlinicCode: state.policlinicCode,
                  doctorCode: state.doctorCode,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is KiosksFailed) {
              return CustomErrorText(message: state.message);
            } else if (state is KiosksSuccess) {
              return MakeAppointmentScreenSuccessBody(kiosks: state.kiosks);
            } else {
              return const Center(
                child: CustomLoadingIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class MakeAppointmentScreenSuccessBody extends StatelessWidget {
  const MakeAppointmentScreenSuccessBody({Key? key, required this.kiosks}) : super(key: key);

  final List<Kiosk> kiosks;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        kiosks.length,
        (index) {
          final kiosk = kiosks[index];
          return InfoCardTemplate(
            leading: const Icon(
              Icons.apartment,
              color: AppColors.kashmirBlue,
            ),
            title: kiosk.servisAdi.toString(),
            subtitle: kiosk.doctorfullname!.replaceAll("  ", " "),
            onTap: () {
              context.read<MakeAppointmentCubit>().acceptanceControl(
                    kiosk.servisKodu!.round().toString(),
                    CacheRepository.getPatientNo(),
                    kiosk.servisAdi.toString(),
                    kiosk.doktorKodu!.round().toString(),
                  );
            },
          );
        },
      ),
    );
  }
}

class AppointmentFailedDialog extends StatelessWidget {
  const AppointmentFailedDialog({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const Divider(),
          const SizedBox(height: AppDimensions.smallGap),
          Text(
            AppStrings.appointmentDialogMessage.trim(),
          ),
          const SizedBox(height: AppDimensions.smallGap),
          AppButton(
            text: AppStrings.ok,
            onPressed: () => context.pop(),
          )
        ],
      ),
    );
  }
}

class AppointmentSuccessDialog extends StatelessWidget {
  const AppointmentSuccessDialog({
    Key? key,
    required this.policlinicName,
    required this.policlinicCode,
    required this.doctorCode,
  }) : super(key: key);

  final String policlinicName;
  final String policlinicCode;
  final String doctorCode;

  @override
  Widget build(BuildContext context) {
    final String message = '$policlinicName adlı poliklinikten randevu almak istediğinize emin misiniz?';

    return AlertDialog(
      title: const Text('Randevu Onayı'),
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: () async {
            final response = await getIt.get<HospitalRepository>().makeAppointment(
                  policlinicCode,
                  CacheRepository.getPatientNo(),
                  doctorCode,
                );

            response.fold(
              (l) => showErrorMessage(l.message),
              (r) => showSuccessMessage(AppStrings.appointmentSuccessMessage),
            );

            // ignore: use_build_context_synchronously
            context.pop();
          },
          child: const Text('Randevu Al'),
        ),
      ],
    );
  }
}
