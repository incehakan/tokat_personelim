import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/models/pdks_information_model.dart';
import '../../../data/repository/pdks_repository.dart';

part 'pdks_info_state.dart';

class PdksInfoCubit extends Cubit<PdksInfoState> {
  PdksInfoCubit(this.pdksRepository) : super(PdksInfoInitial());

  final PdksRepository pdksRepository;

  Future<void> getInformations(String startDate, String endDate) async {
    emit(PdksInfoInProgress());
    final response = await pdksRepository.fetchPdksInformations(startDate, endDate);
    response.fold(
      (l) => emit(PdksInfoFailed(l.message)),
      (r) => emit(PdksInfoSuccess(r)),
    );
  }
}
