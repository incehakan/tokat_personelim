import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/last_entrance_model.dart';
import '../../../../data/repository/pdks_repository.dart';

part 'entrance_operations_event.dart';
part 'entrance_operations_state.dart';

class EntranceOperationsBloc extends Bloc<EntranceOperationsEvent, EntranceOperationsState> {
  EntranceOperationsBloc(this.pdksRepository) : super(const EntranceOperationsState()) {
    on<GetLastEntrance>((event, emit) => _onGetLastEntrance(event, emit));
    on<MakeEntrance>((event, emit) => _onMakeEntrance(event, emit));
  }

  final PdksRepository pdksRepository;

  // Son giriş çıkış işlemini getiren fonksiyon.
  Future<void> _onGetLastEntrance(
    GetLastEntrance event,
    Emitter<EntranceOperationsState> emit,
  ) async {
    emit(
      state.copyWith(status: EntranceOperationsStatus.lastEntranceLoading),
    );
    final response = await pdksRepository.fetchLastEntrance();
    response.fold(
      (l) => emit(
        state.copyWith(status: EntranceOperationsStatus.lastEntranceFailed),
      ),
      (lastEntrances) {
        emit(
          state.copyWith(
            status: EntranceOperationsStatus.lastEntranceSuccess,
            lastEntrance: lastEntrances.first,
            entranceType: lastEntrances.first.id!.round() == 1 ? EntranceType.entrance : EntranceType.exit,
          ),
        );
      },
    );
  }

  // Giriş-Çıkış işlemi yapmak için kullanılan fonksiyon
  Future<void> _onMakeEntrance(
    MakeEntrance event,
    Emitter<EntranceOperationsState> emit,
  ) async {
    emit(state.copyWith(
      status: EntranceOperationsStatus.entranceOperationInProgress,
    ));

    final response = await pdksRepository.pdksEntranceOperation(
      event.entranceType == EntranceType.entrance ? "1" : "0",
      event.deviceId,
    );
    response.fold(
      (l) => emit(
        state.copyWith(
          status: EntranceOperationsStatus.entranceOperationFailed,
          message: l.message,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            status: EntranceOperationsStatus.entraneOperationSuccess,
          ),
        );

        add(const GetLastEntrance());
      },
    );
  }
}
