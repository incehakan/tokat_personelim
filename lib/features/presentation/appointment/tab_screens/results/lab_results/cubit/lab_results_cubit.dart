import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/lab_result_model.dart';
import '../../../../../../data/repository/hospital_repository.dart';

part 'lab_results_state.dart';

class LabResultsCubit extends Cubit<LabResultsState> {
  LabResultsCubit(this.hospitalRepository) : super(LabResultsInitial());

  final HospitalRepository hospitalRepository;

  Future<void> getLabResults(String registryNo) async {
    emit(LabResultsInPrgress());
    final response = await hospitalRepository.fetchLabResults(registryNo);
    response.fold(
      (l) => emit(LabResultsFailed(l.message)),
      (r) => emit(LabResultsSuccess(r)),
    );
  }
}
