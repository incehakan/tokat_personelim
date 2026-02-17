part of 'driver_hours_bloc.dart';

enum DriverHoursStatus {
  initial,
  loading,
  success,
  failure,
}

class DriverHoursState extends Equatable {
  const DriverHoursState({
    this.status = DriverHoursStatus.initial,
    this.driverHours,
    this.statusMessage,
  });

  final DriverHoursStatus status;
  final List<DriverHours>? driverHours;
  final String? statusMessage;

  DriverHoursState copyWith({
    DriverHoursStatus? status,
    List<DriverHours>? driverHours,
    String? statusMessage,
  }) {
    return DriverHoursState(
      status: status ?? this.status,
      driverHours: driverHours ?? this.driverHours,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        driverHours ?? "",
        statusMessage ?? "",
      ];
}
