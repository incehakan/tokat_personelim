part of 'change_password_cubit.dart';

@immutable
class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordInProgress extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  final String message;

  ChangePasswordSuccess(this.message);
}

class ChangePasswordFailed extends ChangePasswordState {
  final String message;

  ChangePasswordFailed(this.message);
}
