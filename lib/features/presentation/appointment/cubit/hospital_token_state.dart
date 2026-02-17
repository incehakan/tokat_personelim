part of 'hospital_token_cubit.dart';

@immutable
class HospitalTokenState {}

class HospitalTokenInitial extends HospitalTokenState {}

class HospitalTokenInProgress extends HospitalTokenState {}

class HospitalTokenSuccess extends HospitalTokenState {}

class HospitalTokenFailed extends HospitalTokenState {
  final String message;

  HospitalTokenFailed(this.message);
}
