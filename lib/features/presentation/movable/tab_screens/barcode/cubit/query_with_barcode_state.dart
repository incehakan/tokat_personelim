part of 'query_with_barcode_cubit.dart';

@immutable
class QueryWithBarcodeState {}

class QueryWithBarcodeInitial extends QueryWithBarcodeState {}

class QueryWithBarcodeInProgress extends QueryWithBarcodeState {}

class QueryWithBarcodeSuccess extends QueryWithBarcodeState {
  final Fixture fixture;

  QueryWithBarcodeSuccess(this.fixture);
}

class QueryWithBarcodeFailed extends QueryWithBarcodeState {
  final String message;

  QueryWithBarcodeFailed(this.message);
}
