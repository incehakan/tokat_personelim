import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../data/models/bus_route_model.dart';
import '../../../../../product/constants/endpoints.dart';
import '../../../../../product/utils/network_manager.dart';

import 'package:xml/xml.dart' as xml;

import '../../../../../product/constants/app_strings.dart';

part 'bus_route_event.dart';
part 'bus_route_state.dart';

class BusRouteBloc extends Bloc<BusRouteEvent, BusRouteState> {
  BusRouteBloc(this.networkManager) : super(const BusRouteState()) {
    on<GetBusRoute>((event, emit) => _onGetBusRoute(event, emit));
  }

  final NetworkManager networkManager;

  Future<void> _onGetBusRoute(
    GetBusRoute event,
    Emitter<BusRouteState> emit,
  ) async {
    emit(state.copyWith(status: BusRouteStatus.loading));
    try {
      List<LatLng> coordinates = [];
      Map<PolylineId, Polyline> polylines = {};

      final response = await networkManager.get(Endpoints.busRoute, queryParameters: {
        "p_hat_no": event.routeNo,
      });

      final data = BusRouteModel.fromJson(response.data);
      if (data.routes != null) {
        final document = xml.XmlDocument.parse(data.routes!.last.gidisXml.toString());
        final markersNode = document.findElements('markers').first;
        final markers = markersNode.findElements('marker');

        for (var marker in markers) {
          coordinates.add(
            LatLng(
              double.parse(marker.attributes[1].value.toString()),
              double.parse(
                marker.attributes[0].value.toString(),
              ),
            ),
          );
        }

        PolylineId id = const PolylineId('busRoute');
        Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.blue,
          points: coordinates,
          width: 6,
        );

        polylines[id] = polyline;
        emit(state.copyWith(
          status: BusRouteStatus.success,
          polylines: polylines,
        ));
      } else {
        emit(state.copyWith(
          status: BusRouteStatus.failure,
          statusMessage: AppStrings.notFoundBusRoutes,
        ));
      }
    } on DioException catch (_) {
      emit(state.copyWith(
        status: BusRouteStatus.failure,
        statusMessage: AppStrings.notFoundBusRoutes,
      ));
    }
  }
}
