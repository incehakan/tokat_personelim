part of 'phone_book_cubit.dart';

@immutable
class PhoneBookState {}

class PhoneBookInitial extends PhoneBookState {}

class PhoneBookInProgress extends PhoneBookState {}

class PhoneBookSuccess extends PhoneBookState {
  final List<PhoneBook> phones;

  PhoneBookSuccess(this.phones);
}

class PhoneBookFailed extends PhoneBookState {
  final String message;

  PhoneBookFailed(this.message);
}
