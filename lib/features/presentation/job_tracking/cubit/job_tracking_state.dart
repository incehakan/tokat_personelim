part of 'job_tracking_cubit.dart';

@immutable
class JobTrackingState {}

class JobTrackingInitial extends JobTrackingState {}

class JobTrackingInProgress extends JobTrackingState {}

class JobTrackingSuccess extends JobTrackingState {
  final String link;

  JobTrackingSuccess(this.link);
}

class JobTrackingFailed extends JobTrackingState {
  final String message;

  JobTrackingFailed(this.message);
}
