part of 'lab_results_cubit.dart';

@immutable
class LabResultsState {}

class LabResultsInitial extends LabResultsState {}

class LabResultsInPrgress extends LabResultsState {}

class LabResultsSuccess extends LabResultsState {
  final List<LabResult> results;

  LabResultsSuccess(this.results);
}

class LabResultsFailed extends LabResultsState {
  final String message;

  LabResultsFailed(this.message);
}
