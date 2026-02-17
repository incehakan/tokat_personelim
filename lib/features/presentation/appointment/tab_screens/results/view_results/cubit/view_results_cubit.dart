import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/view_result_model.dart';
import '../../../../../../data/repository/hospital_repository.dart';

part 'view_results_state.dart';

class ViewResultsCubit extends Cubit<ViewResultsState> {
  ViewResultsCubit(this.hospitalRepository) : super(ViewResultsInitial());

  final HospitalRepository hospitalRepository;

  Future<void> getViewResults(String registryNo) async {
    emit(ViewResultsInProgess());
    final response = await hospitalRepository.fetchViewResults(registryNo);
    response.fold(
      (l) => emit(ViewResultsFailed(l.message)),
      (r) => emit(ViewResultsSuccess(r)),
    );
  }
}
