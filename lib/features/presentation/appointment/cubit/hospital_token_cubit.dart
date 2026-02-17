import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/repository/hospital_repository.dart';

part 'hospital_token_state.dart';

class HospitalTokenCubit extends Cubit<HospitalTokenState> {
  HospitalTokenCubit(this.hospitalRepository) : super(HospitalTokenInitial());

  final HospitalRepository hospitalRepository;

  Future<void> getHospitalToken() async {
    emit(HospitalTokenInProgress());
    final response = await hospitalRepository.fetchHospitalToken();
    response.fold(
      (l) => emit(HospitalTokenFailed(l.message)),
      (r) => emit(HospitalTokenSuccess()),
    );
  }
}
