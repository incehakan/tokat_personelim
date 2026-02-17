part of 'make_appointment_cubit.dart';

@immutable
class MakeAppointmentState {}

class MakeAppointmentInitial extends MakeAppointmentState {}

class KiosksInProgress extends MakeAppointmentState {}

class KiosksSuccess extends MakeAppointmentState {
  final List<Kiosk> kiosks;

  KiosksSuccess(this.kiosks);
}

class KiosksFailed extends MakeAppointmentState {
  final String message;

  KiosksFailed(this.message);
}

class AcceptanceControlInProgress extends MakeAppointmentState {}

class AcceptanceControlSuccess extends MakeAppointmentState {
  final String policlinicName;
  final String policlinicCode;
  final String doctorCode;

  AcceptanceControlSuccess(this.policlinicName, this.policlinicCode, this.doctorCode);
}

class AcceptanceControlFailed extends MakeAppointmentState {
  final String message;

  AcceptanceControlFailed(this.message);
}
