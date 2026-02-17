part of 'view_results_cubit.dart';

@immutable
class ViewResultsState {}

class ViewResultsInitial extends ViewResultsState {}

class ViewResultsInProgess extends ViewResultsState {}

class ViewResultsSuccess extends ViewResultsState {
  final List<ViewResult> results;

  ViewResultsSuccess(this.results);
}

class ViewResultsFailed extends ViewResultsState {
  final String message;

  ViewResultsFailed(this.message);
}
