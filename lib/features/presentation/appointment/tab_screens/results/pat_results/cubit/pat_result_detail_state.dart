part of 'pat_result_detail_cubit.dart';

@immutable
class PatResultDetailState {}

class PatResultDetailInitial extends PatResultDetailState {}

class PatResultDetailInProgress extends PatResultDetailState {}

class PatResultDetailSuccess extends PatResultDetailState {
  final List<PatResultDetail> results;

  PatResultDetailSuccess(this.results);
}

class PatResultDetailFailed extends PatResultDetailState {
  final String message;

  PatResultDetailFailed(this.message);
}
