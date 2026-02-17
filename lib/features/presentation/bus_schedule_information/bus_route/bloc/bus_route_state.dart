part of 'bus_route_bloc.dart';

enum BusRouteStatus {
  initial,
  loading,
  success,
  failure,
}

class BusRouteState extends Equatable {
  const BusRouteState({
    this.status = BusRouteStatus.initial,
    this.polylines,
    this.statusMessage,
  });

  final BusRouteStatus status;
  final Map<PolylineId, Polyline>? polylines;
  final String? statusMessage;

  BusRouteState copyWith({
    BusRouteStatus? status,
    Map<PolylineId, Polyline>? polylines,
    String? statusMessage,
  }) {
    return BusRouteState(
      status: status ?? this.status,
      polylines: polylines ?? this.polylines,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        polylines ?? "",
        statusMessage ?? "",
      ];
}
