part of 'home_bloc.dart';

enum HomeStatus {
  initial,
  loading,

  // Menünün çekildiği servisin stateleri.
  menuSuccess,
  menuFailed,

  // Pop-Up state
  popUpSuccess,

  // Firebase bildirimlerinin yönetildiği state
  firebaseMessageSuccess,
}

class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.menu,
    this.statusMessage,
    this.popUp,
  });

  final HomeStatus status;
  final List<MenuItem>? menu;
  final String? statusMessage;
  final ActivePopUp? popUp;

  HomeState copyWith({
    HomeStatus? status,
    List<MenuItem>? menu,
    String? statusMessage,
    ActivePopUp? popUp,
  }) {
    return HomeState(
      status: status ?? this.status,
      menu: menu ?? this.menu,
      statusMessage: statusMessage ?? this.statusMessage,
      popUp: popUp ?? this.popUp,
    );
  }

  @override
  List<Object> get props => [
        status,
        menu ?? [],
        statusMessage ?? "",
        popUp ?? "",
      ];
}
