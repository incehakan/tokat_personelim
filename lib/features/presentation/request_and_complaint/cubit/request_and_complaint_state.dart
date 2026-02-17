part of 'request_and_complaint_cubit.dart';

class RequestAndComplaintState extends Equatable {
  const RequestAndComplaintState();

  @override
  List<Object> get props => [];
}

class RequestAndComplaintInitial extends RequestAndComplaintState {}

class RequestAndComplaintLoading extends RequestAndComplaintState {}

class RequestAndComplaintFailed extends RequestAndComplaintState {
  final String message;

  const RequestAndComplaintFailed(this.message);
}

class RequestAndComplaintSuccess extends RequestAndComplaintState {
  final String message;

  const RequestAndComplaintSuccess(this.message);
}
