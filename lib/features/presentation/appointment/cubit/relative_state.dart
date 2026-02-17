part of 'relative_cubit.dart';

@immutable
class RelativeState {}

class RelativeInitial extends RelativeState {}

class RelativeInProgress extends RelativeState {}

class RelativeSuccess extends RelativeState {
  final List<Relative> relatives;

  RelativeSuccess(this.relatives);
}

class RelativeFailed extends RelativeState {
  final String message;

  RelativeFailed(this.message);
}
