part of 'appointments_cubit.dart';

@immutable
class AppointmentsState {}

class AppointmentsInitial extends AppointmentsState {}

class AppointmentsInProgress extends AppointmentsState {}

class AppointmentsSuccess extends AppointmentsState {
  final List<Appointment> appointments;

  AppointmentsSuccess(this.appointments);
}

class AppointmentsFailed extends AppointmentsState {
  final String message;

  AppointmentsFailed(this.message);
}

class AppointmentCancelInProgress extends AppointmentsState {}

class AppointmentCancelSuccess extends AppointmentsState {}

class AppointmentCancelFailed extends AppointmentsState {
  final String message;

  AppointmentCancelFailed(this.message);
}
