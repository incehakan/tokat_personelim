import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../widgets/custom_error_text.dart';

import '../../../../../product/constants/app_colors.dart';
import '../../../../../product/constants/app_dimensions.dart';
import '../../../../../product/constants/app_strings.dart';
import '../../../../../product/utils/dependency_injection.dart';
import '../../../../../product/utils/show_error_message.dart';
import '../../../../../product/utils/show_loading_indicator.dart';
import '../../../../data/models/appointment_model.dart';
import '../../../../data/repository/cache_repository.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/info_card_template.dart';
import '../../../../widgets/loading_indicator.dart';
import 'cubit/appointments_cubit.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<AppointmentsCubit>()
        ..getAppointments(
          CacheRepository.getPatientRegistryNo(),
        ),
      child: Padding(
        padding: AppDimensions.pagePadding,
        child: BlocConsumer<AppointmentsCubit, AppointmentsState>(
          listener: (context, state) {
            if (state is AppointmentCancelInProgress) {
              showLoadingIndicator(context);
            } else if (state is AppointmentCancelFailed) {
              context.pop();
              showErrorMessage(state.message);
            } else if (state is AppointmentCancelSuccess) {
              context.pop();
              context.pop();
              showSuccessMessage('Randevunuz iptal edilmiştir');
            }
          },
          builder: (context, state) {
            if (state is AppointmentsFailed) {
              return Center(child: CustomErrorText(message: state.message));
            } else if (state is AppointmentsSuccess) {
              return AppointmentsScreenSuccessBody(
                appointments: state.appointments,
              );
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

class AppointmentsScreenSuccessBody extends StatelessWidget {
  const AppointmentsScreenSuccessBody({Key? key, required this.appointments}) : super(key: key);

  final List<Appointment> appointments;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        appointments.length,
        (index) {
          final appointment = appointments[index];
          return InfoCardTemplate(
            title: appointment.servisAdi.toString(),
            subtitle: DateFormat.yMMMMd('tr').format(appointment.randevuTarihi!).toString(),
            trailing: TextButton(
              child: const Text(AppStrings.cancel),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => CancelAppointmentDialog(
                    protocolNo: '',
                    protocolId: '',
                    registryNo: '',
                    onPressed: () {
                      context.read<AppointmentsCubit>().cancelAppointment(
                            appointment.protokolNo!.toInt().toString(),
                            appointment.protokolId!.toInt().toString(),
                            CacheRepository.getPatientRegistryNo(),
                          );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CancelAppointmentDialog extends StatelessWidget {
  const CancelAppointmentDialog({
    Key? key,
    required this.protocolNo,
    required this.protocolId,
    required this.registryNo,
    required this.onPressed,
  }) : super(key: key);

  final String protocolNo;
  final String protocolId;
  final String registryNo;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: AppDimensions.cardRadius,
      ),
      content: Text(
        "Randevuyu iptal etmek istediğinize emin misiniz?",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.kashmirBlue,
            ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  onPressed();
                },
                child: const Text('Evet'),
              ),
            ),
            Expanded(
              child: AppButton(
                text: 'Hayır',
                onPressed: () => context.pop(),
              ),
            ),
          ],
        )
      ],
    );
  }
}
