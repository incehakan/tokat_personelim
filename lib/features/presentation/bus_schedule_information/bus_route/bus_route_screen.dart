import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'bloc/bus_route_bloc.dart';
import '../../../../product/utils/network_manager.dart';

import '../../../../product/utils/show_error_message.dart';
import '../../../widgets/loading_indicator.dart';

class BusRouteScreen extends StatefulWidget {
  const BusRouteScreen({Key? key, required this.routeNo}) : super(key: key);

  final String routeNo;

  @override
  State<BusRouteScreen> createState() => _BusRouteScreenState();
}

class _BusRouteScreenState extends State<BusRouteScreen> {
  final bloc = BusRouteBloc(NetworkManager(Dio()));
  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(38.418883, 27.128614),
    zoom: 15,
  );

  late GoogleMapController _googleMapController;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Güzergah Bilgisi'),
      ),
      body: BlocProvider(
        create: (context) => bloc..add(GetBusRoute(widget.routeNo.toString())),
        child: BlocConsumer<BusRouteBloc, BusRouteState>(
          listener: (context, state) {
            if (state.status == BusRouteStatus.failure) {
              showErrorMessage(state.statusMessage);
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case BusRouteStatus.initial:
              case BusRouteStatus.loading:
                return const Center(
                  child: CustomLoadingIndicator(),
                );

              case BusRouteStatus.success:
                return GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                  polylines: Set<Polyline>.of(state.polylines!.values),
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) => _googleMapController = controller,
                );
              case BusRouteStatus.failure:
                return GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) => _googleMapController = controller,
                );
            }
          },
        ),
      ),
    );
  }
}
