part of 'subordinates_cubit.dart';

@immutable
class SubordinatesState {}

class SubordinatesInitial extends SubordinatesState {}

class SubordinatesInProgress extends SubordinatesState {}

class SubordinatesSuccess extends SubordinatesState {
  final List<Subordinate> subordinates;

  SubordinatesSuccess(this.subordinates);
}

class SubordinatesFailed extends SubordinatesState {
  final String message;

  SubordinatesFailed(this.message);
}
