import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../product/utils/determine_position.dart';
import '../../../data/models/pdks_device_model.dart';
import '../../../data/repository/pdks_repository.dart';

part 'nearby_devices_state.dart';

class NearbyDevicesCubit extends Cubit<NearbyDevicesState> {
  NearbyDevicesCubit(this.pdksRepository) : super(NearbyDevicesInitial());

  final PdksRepository pdksRepository;

  Future<void> getDevices() async {
    emit(NearbyDevicesInProgress());
    final response = await getUserPosition();
    response.fold(
      (l) => emit(NearbyDevicesFailed(l)),
      (r) async {
        final response = await pdksRepository.fetchNearbyDevices(
          LatLng(r.latitude, r.longitude),
        );
        response.fold(
          (l) => emit(NearbyDevicesFailed(l.message)),
          (r) => emit(NearbyDevicesSuccess(r)),
        );
      },
    );
  }
}
