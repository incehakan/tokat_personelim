import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/pathology_result_detail_model.dart';
import '../../../../../../data/repository/hospital_repository.dart';

part 'pat_result_detail_state.dart';

class PatResultDetailCubit extends Cubit<PatResultDetailState> {
  PatResultDetailCubit(this.hospitalRepository) : super(PatResultDetailInitial());

  final HospitalRepository hospitalRepository;

  Future<void> getPatResultDetail(String pathologyId, String patientNo) async {
    emit(PatResultDetailInProgress());
    final response = await hospitalRepository.fetchPatResultDetails(pathologyId, patientNo);
    response.fold(
      (l) => emit(PatResultDetailFailed(l.message)),
      (r) => emit(PatResultDetailSuccess(r)),
    );
  }
}
