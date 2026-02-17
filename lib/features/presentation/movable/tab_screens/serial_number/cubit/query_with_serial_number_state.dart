part of 'query_with_serial_number_cubit.dart';

@immutable
class QueryWithSerialNumberState {}

class QueryWithSerialNumberInitial extends QueryWithSerialNumberState {}

class QueryWithSerialNumberInProgress extends QueryWithSerialNumberState {}

class QueryWithSerialNumberSuccess extends QueryWithSerialNumberState {
  final Fixture fixture;

  QueryWithSerialNumberSuccess(this.fixture);
}

class QueryWithSerialNumberFailed extends QueryWithSerialNumberState {
  final String message;

  QueryWithSerialNumberFailed(this.message);
}
