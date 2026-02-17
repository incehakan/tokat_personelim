import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/leave.dart';
import '../../../../../../data/repository/employee_repository.dart';

part 'subordinate_leave_info_state.dart';

class SubordinateLeaveInfoCubit extends Cubit<SubordinateLeaveInfoState> {
  SubordinateLeaveInfoCubit(this.employeeRepository) : super(SubordinateLeaveInfoInitial());

  final EmployeeRepository employeeRepository;

  Future<void> getSubordinateLeaveInfo(String registerNo) async {
    emit(SubordinateLeaveInfoInProgress());
    final response = await employeeRepository.fetchSubordinateLeaveInfo(registerNo);
    response.fold(
      (l) => emit(SubordinateLeaveInfoFailed(l.message)),
      (r) => emit(SubordinateLeaveInfoSuccess(r)),
    );
  }
}
