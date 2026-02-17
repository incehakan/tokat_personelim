part of 'birthday_cubit.dart';

@immutable
class BirthdayState {}

class BirthdayInitial extends BirthdayState {}

class BirthdayInProgress extends BirthdayState {}

class BirthdaySuccess extends BirthdayState {
  final List<Birthday> birthdays;

  BirthdaySuccess(this.birthdays);
}

class BirthdayFailed extends BirthdayState {
  final String message;

  BirthdayFailed(this.message);
}

class BirthdayCelebrateSuccess extends BirthdayState {}

class BirthdayCelebrateFailed extends BirthdayState {
  final String message;

  BirthdayCelebrateFailed(this.message);
}
