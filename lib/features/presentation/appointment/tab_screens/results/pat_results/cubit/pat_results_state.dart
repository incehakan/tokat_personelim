part of 'pat_results_cubit.dart';

@immutable
class PatResultsState {}

class PatResultsInitial extends PatResultsState {}

class PatResultsInProgress extends PatResultsState {}

class PatResultsSuccess extends PatResultsState {
  final List<PathologyResult> results;

  PatResultsSuccess(this.results);
}

class PatResultsFailed extends PatResultsState {
  final String message;

  PatResultsFailed(this.message);
}
