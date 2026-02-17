import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/models/subordinate_pdks_info_model.dart';
import '../../../../../../data/repository/employee_repository.dart';

part 'subordinate_pdks_info_state.dart';

class SubordinatePdksInfoCubit extends Cubit<SubordinatePdksInfoState> {
  SubordinatePdksInfoCubit(this.employeeRepository) : super(SubordinatePdksInfoInitial());

  final EmployeeRepository employeeRepository;

  Future<void> getSubordinatePdksInfo(String registerNo) async {
    emit(SubordinatePdksInfoInProgress());
    final response = await employeeRepository.fetchSubordinatePdksInfo(registerNo);
    response.fold(
      (l) => emit(SubordinatePdksInfoFailed(l.message)),
      (r) => emit(SubordinatePdksInfoSuccess(r)),
    );
  }
}
