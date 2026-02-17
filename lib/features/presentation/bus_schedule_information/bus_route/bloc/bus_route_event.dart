part of 'bus_route_bloc.dart';

class BusRouteEvent extends Equatable {
  const BusRouteEvent();

  @override
  List<Object> get props => [];
}

class GetBusRoute extends BusRouteEvent {
  final String routeNo;

  const GetBusRoute(this.routeNo);
}
