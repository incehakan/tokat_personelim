part of 'nearby_devices_cubit.dart';

@immutable
class NearbyDevicesState {}

class NearbyDevicesInitial extends NearbyDevicesState {}

class NearbyDevicesInProgress extends NearbyDevicesState {}

class NearbyDevicesSuccess extends NearbyDevicesState {
  final List<PdksDevice> devices;

  NearbyDevicesSuccess(this.devices);
}

class NearbyDevicesFailed extends NearbyDevicesState {
  final String message;

  NearbyDevicesFailed(this.message);
}
