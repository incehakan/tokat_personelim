import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../product/utils/network_manager.dart';
import '../../../../product/utils/show_error_message.dart';
import '../../../widgets/loading_indicator.dart';
import 'bloc/bus_location_bloc.dart';

class BusLocationScreen extends StatefulWidget {
  const BusLocationScreen({Key? key, required this.busPlate}) : super(key: key);

  final String busPlate;

  @override
  State<BusLocationScreen> createState() => _BusLocationScreenState();
}

class _BusLocationScreenState extends State<BusLocationScreen> {
  final bloc = BusLocationBloc(NetworkManager(Dio()));

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
        title: const Text('Araç Konumu'),
      ),
      body: BlocProvider(
        create: (context) => bloc
          ..add(GetBusLocations(
            widget.busPlate,
          )),
        child: BlocConsumer<BusLocationBloc, BusLocationState>(
          listener: (context, state) {
            if (state.status == BusLocationStatus.failure) {
              showErrorMessage(state.statusMessage);
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case BusLocationStatus.inital:
              case BusLocationStatus.loading:
                return const Center(
                  child: CustomLoadingIndicator(),
                );
              case BusLocationStatus.failure:
                return GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) => _googleMapController = controller,
                );
              case BusLocationStatus.success:
                return GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                  markers: Set.from(state.markers!),
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
