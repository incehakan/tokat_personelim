part of 'bus_location_bloc.dart';

enum BusLocationStatus {
  inital,
  loading,
  success,
  failure,
}

class BusLocationState extends Equatable {
  const BusLocationState({
    this.status = BusLocationStatus.inital,
    this.markers,
    this.statusMessage,
  });

  final BusLocationStatus status;
  final List<Marker>? markers;
  final String? statusMessage;

  BusLocationState copyWith({
    BusLocationStatus? status,
    List<Marker>? markers,
    String? statusMessage,
  }) {
    return BusLocationState(
      status: status ?? this.status,
      markers: markers ?? this.markers,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        markers ?? [],
        statusMessage ?? "",
      ];
}
