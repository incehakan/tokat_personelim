part of 'lab_result_details_cubit.dart';

@immutable
class LabResultDetailsState {}

class LabResultDetailsInitial extends LabResultDetailsState {}

class LabResultDetailsInProgress extends LabResultDetailsState {}

class LabResultDetailsSuccess extends LabResultDetailsState {
  final List<LabResultDetail> results;

  LabResultDetailsSuccess(this.results);
}

class LabResultDetailsFailed extends LabResultDetailsState {
  final String message;

  LabResultDetailsFailed(this.message);
}
