part of 'driver_hours_bloc.dart';

class DriverHoursEvent extends Equatable {
  const DriverHoursEvent();

  @override
  List<Object> get props => [];
}

class GetDriverHours extends DriverHoursEvent {
  final DateTime date;
  const GetDriverHours(this.date);

  @override
  List<Object> get props => [date];
}
