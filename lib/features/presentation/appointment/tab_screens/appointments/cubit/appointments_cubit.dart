import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/appointment_model.dart';
import '../../../../../data/repository/hospital_repository.dart';

part 'appointments_state.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  AppointmentsCubit(this.hospitalRepository) : super(AppointmentsInitial());

  final HospitalRepository hospitalRepository;

  Future<void> getAppointments(String registryNo) async {
    if (isClosed) {
      return;
    }

    emit(AppointmentsInProgress());
    final response = await hospitalRepository.fetchAppointments(registryNo);
    response.fold(
      (l) => emit(AppointmentsFailed(l.message)),
      (r) => emit(AppointmentsSuccess(r)),
    );
  }

  Future<void> cancelAppointment(
    String protocolNo,
    String protocolId,
    String registryNo,
  ) async {
    emit(AppointmentCancelInProgress());
    final response = await hospitalRepository.cancelAppointment(
      protocolNo,
      protocolId,
      registryNo,
    );
    response.fold(
      (l) => emit(AppointmentCancelFailed(l.message)),
      (r) => emit(AppointmentCancelSuccess()),
    );
    await getAppointments(registryNo);
  }
}
