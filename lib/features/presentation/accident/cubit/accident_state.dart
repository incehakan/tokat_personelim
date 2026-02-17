part of 'accident_cubit.dart';

@immutable
class AccidentState {}

class AccidentInitial extends AccidentState {}

class AccidentReportsInProgress extends AccidentState {}

class AccidentReportsSuccess extends AccidentState {
  final List<AccidentReport> reports;

  AccidentReportsSuccess(this.reports);
}

class AccidentReportsFailed extends AccidentState {
  final String message;

  AccidentReportsFailed(this.message);
}

class NewAccidentInProgress extends AccidentState {}

class NewAccidentSuccess extends AccidentState {
  final String message;

  NewAccidentSuccess(this.message);
}

class NewAccidentFailed extends AccidentState {
  final String message;

  NewAccidentFailed(this.message);
}
