import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../product/constants/app_images.dart';
import '../../../../../product/constants/app_strings.dart';
import '../../../../../product/constants/endpoints.dart';
import '../../../../../product/utils/network_manager.dart';
import '../../../../data/models/bus_location_model.dart';

part 'bus_location_event.dart';
part 'bus_location_state.dart';

class BusLocationBloc extends Bloc<BusLocationEvent, BusLocationState> {
  BusLocationBloc(this.networkManager) : super(const BusLocationState()) {
    on<GetBusLocations>((event, emit) => _onGetBusLocations(event, emit));
  }

  final NetworkManager networkManager;

  Future<void> _onGetBusLocations(
    GetBusLocations event,
    Emitter<BusLocationState> emit,
  ) async {
    List<Marker> markers = [];

    emit(state.copyWith(status: BusLocationStatus.loading));

    try {
      final response = await networkManager.get(
        Endpoints.busLocation,
        queryParameters: {
          "plaka_no": event.busPlate,
        },
      );
      final data = BusLocationModel.fromJson(response.data);
      if (data.busLocation != null) {
        if (data.busLocation!.enlem != null) {
          final latitude = double.parse(
            data.busLocation!.enlem!.replaceAll(",", "."),
          );
          final longitude = double.parse(
            data.busLocation!.enlem!.replaceAll(",", "."),
          );

          markers.clear();
          BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(
              size: Size(24, 24),
            ),
            AppImages.busImage,
          ).then(
            (value) {
              final Marker marker = Marker(
                markerId: const MarkerId('busLocation'),
                position: LatLng(latitude, longitude),
                icon: value,
              );
              markers.add(marker);
              emit(
                state.copyWith(
                  status: BusLocationStatus.success,
                  markers: markers,
                ),
              );
            },
          );
        } else {
          emit(state.copyWith(
            status: BusLocationStatus.failure,
            statusMessage: AppStrings.notFoundBusLocation,
          ));
        }
      } else {
        emit(state.copyWith(
          status: BusLocationStatus.failure,
          statusMessage: AppStrings.notFoundBusLocation,
        ));
      }
    } on DioException catch (err) {
      emit(state.copyWith(
        status: BusLocationStatus.failure,
        statusMessage: err.response!.statusMessage,
      ));
    }
  }
}
