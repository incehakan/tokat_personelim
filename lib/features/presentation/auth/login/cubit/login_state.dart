part of 'login_cubit.dart';

@immutable
class LoginState {}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {
  final String code;

  LoginSuccess(this.code);
}

class LoginFailed extends LoginState {
  final String message;

  LoginFailed(this.message);
}
