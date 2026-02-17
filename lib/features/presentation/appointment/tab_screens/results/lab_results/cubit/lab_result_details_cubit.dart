import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/lab_result_detail_model.dart';
import '../../../../../../data/repository/hospital_repository.dart';

part 'lab_result_details_state.dart';

class LabResultDetailsCubit extends Cubit<LabResultDetailsState> {
  LabResultDetailsCubit(this.hospitalRepository) : super(LabResultDetailsInitial());

  final HospitalRepository hospitalRepository;

  Future<void> getLabResultDetails(String protocolNo, String patientNo) async {
    emit(LabResultDetailsInProgress());
    final response = await hospitalRepository.fetchLabResultDetails(
      protocolNo,
      patientNo,
    );
    response.fold(
      (l) => emit(LabResultDetailsFailed(l.message)),
      (r) => emit(LabResultDetailsSuccess(r)),
    );
  }
}
