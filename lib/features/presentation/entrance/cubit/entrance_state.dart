part of 'entrance_cubit.dart';

@immutable
class EntranceState {}

class EntranceInitial extends EntranceState {}

class EntranceInProgress extends EntranceState {}

class EntranceSuccess extends EntranceState {
  final String message;

  EntranceSuccess(this.message);
}

class EntranceFailed extends EntranceState {
  final String message;

  EntranceFailed(this.message);
}

class LastEntranceInProgress extends EntranceState {}

class LastEntranceSuccess extends EntranceState {
  final LastEntrance lastEntrance;

  LastEntranceSuccess(this.lastEntrance);
}

class LastEntranceFailed extends EntranceState {
  final String message;

  LastEntranceFailed(this.message);
}
