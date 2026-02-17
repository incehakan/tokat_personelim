import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/models/movable_count_model.dart';
import '../../../data/repository/corporate_repository.dart';

import '../../../data/models/fixture_unit_model.dart';
import '../../../data/models/movable_model.dart';
import '../../../data/models/service_model.dart';

part 'movable_count_state.dart';

class MovableCountCubit extends Cubit<MovableCountState> {
  MovableCountCubit(this.corporateRepository) : super(MovableCountInitial());

  final CorporateRepository corporateRepository;

  FixtureUnit? selectedUnit;

  ServiceData? selectedService;

  ServiceData? selectedRoom;

  MovableData? selectedMovable;

  void selectUnit(FixtureUnit unit) {
    selectedUnit = unit;
  }

  void selectService(ServiceData service) {
    selectedService = service;
  }

  void selectRoom(ServiceData service) {
    selectedRoom = service;
  }

  void selectMovable(MovableData movable) {
    selectedMovable = movable;
  }

  Future<void> getServices(String unitId) async {
    emit(ServicesInProgress());
    final response = await corporateRepository.fetchServices(unitId);
    response.fold(
      (l) => emit(ServicesFailed(l.message)),
      (r) => emit(ServicesSuccess(r)),
    );
  }

  Future<void> getRooms(String serviceId) async {
    emit(RoomsInProgress());
    final response = await corporateRepository.fetchRooms(serviceId);
    response.fold(
      (l) => emit(RoomsFailed(l.message)),
      (r) => emit(RoomsSuccess(r)),
    );
  }

  Future<void> getMovables(String query) async {
    emit(MovablesInProgress());
    final response = await corporateRepository.fetchMovables(query);
    response.fold(
      (l) => emit(MovablesFailed(l.message)),
      (r) => emit(MovablesSuccess(r)),
    );
  }

  Future<void> getMovableCounts(String unitId) async {
    emit(MovableCountsInProgress());
    final response = await corporateRepository.fetchAddedMovables(unitId);
    response.fold(
      (l) => emit(MovableCountsFailed(l.message)),
      (r) => emit(MovableCountsSuccess(r)),
    );
  }

  void clearValues() {
    selectedUnit = null;
    selectedService = null;
    selectedRoom = null;
    selectedMovable = null;
  }
}
