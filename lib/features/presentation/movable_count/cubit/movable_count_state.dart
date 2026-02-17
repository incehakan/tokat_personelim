part of 'movable_count_cubit.dart';

@immutable
class MovableCountState {}

class MovableCountInitial extends MovableCountState {}

class ServicesInProgress extends MovableCountState {}

class ServicesSuccess extends MovableCountState {
  final List<ServiceData> services;

  ServicesSuccess(this.services);
}

class ServicesFailed extends MovableCountState {
  final String message;

  ServicesFailed(this.message);
}

class RoomsInProgress extends MovableCountState {}

class RoomsSuccess extends MovableCountState {
  final List<ServiceData> services;

  RoomsSuccess(this.services);
}

class RoomsFailed extends MovableCountState {
  final String message;

  RoomsFailed(this.message);
}

class MovablesInProgress extends MovableCountState {}

class MovablesSuccess extends MovableCountState {
  final List<MovableData> movables;

  MovablesSuccess(this.movables);
}

class MovablesFailed extends MovableCountState {
  final String message;

  MovablesFailed(this.message);
}

class MovableCountsInProgress extends MovableCountState {}

class MovableCountsSuccess extends MovableCountState {
  final MovableCountModelData modelData;

  MovableCountsSuccess(this.modelData);
}

class MovableCountsFailed extends MovableCountState {
  final String message;

  MovableCountsFailed(this.message);
}
