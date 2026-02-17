import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/models/employee_relative_model.dart';
import '../../../data/repository/hospital_repository.dart';

part 'relative_state.dart';

class RelativeCubit extends Cubit<RelativeState> {
  RelativeCubit(this.repository) : super(RelativeInitial());

  final HospitalRepository repository;

  Future<void> getRelatives() async {
    emit(RelativeInProgress());
    final response = await repository.fetchEmployeeRelatives();
    response.fold(
      (l) => emit(RelativeFailed(l.message)),
      (r) => emit(RelativeSuccess(r)),
    );
  }
}
