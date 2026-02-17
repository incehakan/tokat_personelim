part of 'bus_location_bloc.dart';

class BusLocationEvent extends Equatable {
  const BusLocationEvent();

  @override
  List<Object> get props => [];
}

class GetBusLocations extends BusLocationEvent {
  final String busPlate;

  const GetBusLocations(this.busPlate);

  @override
  List<Object> get props => [busPlate];
}
