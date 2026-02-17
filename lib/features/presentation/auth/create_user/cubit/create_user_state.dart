part of 'create_user_cubit.dart';

@immutable
class CreateUserState {}

class CreateUserInitial extends CreateUserState {}

class CreateUserInProgress extends CreateUserState {}

class CreateUserSuccess extends CreateUserState {
  final String message;

  CreateUserSuccess(this.message);
}

class CreateUserFailed extends CreateUserState {
  final String message;

  CreateUserFailed(this.message);
}
