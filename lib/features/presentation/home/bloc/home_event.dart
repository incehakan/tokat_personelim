part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetMenuItems extends HomeEvent {
  const GetMenuItems();
}

class GetUserInfo extends HomeEvent {
  const GetUserInfo();
}

class GetActivePopUp extends HomeEvent {
  const GetActivePopUp();
}

class SendFirebaseToken extends HomeEvent {
  const SendFirebaseToken();
}

class InitializeFirebaseMessages extends HomeEvent {
  const InitializeFirebaseMessages();
}
