import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/models/last_entrance_model.dart';
import '../../../data/repository/pdks_repository.dart';

part 'entrance_state.dart';

class EntranceCubit extends Cubit<EntranceState> {
  EntranceCubit(this.pdksRepository) : super(EntranceInitial());

  final PdksRepository pdksRepository;

  int? entranceType;

  String get entranceTypeText => entranceType == 1 ? 'GİRİŞ' : 'ÇIKIŞ';

  String get entranceTypeReverseText => entranceType == 1 ? 'ÇIKIŞ' : 'GİRİŞ';

  Future<void> getLastEntrance() async {
    emit(LastEntranceInProgress());
    final response = await pdksRepository.fetchLastEntrance();
    response.fold(
      (l) => emit(LastEntranceFailed(l.message)),
      (r) {
        entranceType = r.first.entranceType!.round();
        emit(LastEntranceSuccess(r.first));
      },
    );
  }

  Future<void> entranceOperation({
    required String entranceType,
    required String deviceId,
  }) async {
    emit(EntranceInProgress());
    final response = await pdksRepository.pdksEntranceOperation(
      entranceType,
      deviceId,
    );
    response.fold(
      (l) => emit(EntranceFailed(l.message)),
      (r) => emit(EntranceSuccess(r)),
    );
    await getLastEntrance();
  }
}
