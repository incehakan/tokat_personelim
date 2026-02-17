import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/repository/employee_repository.dart';

import '../../../data/models/subordinates_model.dart';

part 'subordinates_state.dart';

class SubordinatesCubit extends Cubit<SubordinatesState> {
  SubordinatesCubit(this.employeeRepository) : super(SubordinatesInitial());

  final EmployeeRepository employeeRepository;

  Future<void> getSubordinates() async {
    emit(SubordinatesInProgress());
    final response = await employeeRepository.fetchSubordinates();
    response.fold(
      (l) => emit(SubordinatesFailed(l.message)),
      (r) => emit(SubordinatesSuccess(r)),
    );
  }
}
