import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import '../../../../../data/models/kiosk_model.dart';
import '../../../../../data/repository/cache_repository.dart';
import '../../../../../data/repository/hospital_repository.dart';

part 'make_appointment_state.dart';

class MakeAppointmentCubit extends Cubit<MakeAppointmentState> {
  MakeAppointmentCubit(this.hospitalRepository) : super(MakeAppointmentInitial());

  final HospitalRepository hospitalRepository;

  Future<void> getKiosks(String registryNo) async {
    if (isClosed) {
      return;
    }
    emit(KiosksInProgress());
    final patientInfoResponse = await hospitalRepository.fetchPatientInformation(registryNo);
    patientInfoResponse.fold(
      (l) => emit(KiosksFailed(l.message)),
      (r) async {
        final earlyRegistrationResponse = await hospitalRepository.fetchEarlyRegistration(
          r.hastaNo.toString(),
        );
        earlyRegistrationResponse.fold(
          (l) => emit(KiosksFailed(l.message)),
          (r) async {
            final kiosksResponse = await hospitalRepository.fetchKiosks();
            kiosksResponse.fold(
              (l) => emit(KiosksFailed(l.message)),
              (r) => emit(KiosksSuccess(r)),
            );
          },
        );
      },
    );
  }

  Future<void> acceptanceControl(
    String policlinicCode,
    String patientNo,
    String policlinicName,
    String doctorCode,
  ) async {
    emit(AcceptanceControlInProgress());
    final response = await hospitalRepository.serviceAcceptanceControl(
      policlinicCode,
      patientNo,
    );
    response.fold(
      (l) => emit(AcceptanceControlFailed(l.message)),
      (r) async {
        final response = await hospitalRepository.patientAcceptanceControl(
          policlinicCode,
          patientNo,
        );
        response.fold(
          (l) => emit(AcceptanceControlFailed(l.message)),
          (r) async {
            final response = await hospitalRepository.fetchPatientAppointments(
              policlinicCode,
              patientNo,
            );
            response.fold(
              (l) => emit(AcceptanceControlFailed(l.message)),
              (r) => emit(AcceptanceControlSuccess(
                policlinicName,
                policlinicCode,
                doctorCode,
              )),
            );
          },
        );
      },
    );
    getKiosks(CacheRepository.getPatientRegistryNo());
  }
}
