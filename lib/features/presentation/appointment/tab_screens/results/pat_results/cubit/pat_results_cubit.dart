import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/pathology_result_model.dart';
import '../../../../../../data/repository/hospital_repository.dart';

part 'pat_results_state.dart';

class PatResultsCubit extends Cubit<PatResultsState> {
  PatResultsCubit(this.hospitalRepository) : super(PatResultsInitial());

  final HospitalRepository hospitalRepository;

  Future<void> getPathologyResults(String registryNo) async {
    emit(PatResultsInProgress());
    final response = await hospitalRepository.fetchPatResults(registryNo);
    response.fold(
      (l) => emit(PatResultsFailed(l.message)),
      (r) => emit(PatResultsSuccess(r)),
    );
  }
}
