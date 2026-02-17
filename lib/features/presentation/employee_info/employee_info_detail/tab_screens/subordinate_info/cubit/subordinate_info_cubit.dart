import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/user_info_model.dart';
import '../../../../../../data/repository/employee_repository.dart';

part 'subordinate_info_state.dart';

class SubordinateInfoCubit extends Cubit<SubordinateInfoState> {
  SubordinateInfoCubit(this.employeeRepository) : super(SubordinateInfoInitial());

  final EmployeeRepository employeeRepository;

  Future<void> getSubordinateInfo(String registerNo) async {
    emit(SubordinateInfoInProgress());
    final response = await employeeRepository.fetchSubordinateInfo(registerNo);
    response.fold(
      (l) => emit(SubordinateInfoFailed(l.message)),
      (r) => emit(SubordinateInfoSuccess(r)),
    );
  }
}
