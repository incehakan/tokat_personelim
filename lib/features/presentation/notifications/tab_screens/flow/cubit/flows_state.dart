part of 'flows_cubit.dart';

@immutable
class FlowsState {}

class FlowsInitial extends FlowsState {}

class FlowsInProgress extends FlowsState {}

class FlowsSuccess extends FlowsState {
  final List<Feed> feeds;

  FlowsSuccess(this.feeds);
}

class FlowsFailed extends FlowsState {
  final String message;

  FlowsFailed(this.message);
}
