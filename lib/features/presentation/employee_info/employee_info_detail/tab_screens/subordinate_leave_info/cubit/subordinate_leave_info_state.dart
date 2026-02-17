part of 'subordinate_leave_info_cubit.dart';

@immutable
class SubordinateLeaveInfoState {}

class SubordinateLeaveInfoInitial extends SubordinateLeaveInfoState {}

class SubordinateLeaveInfoInProgress extends SubordinateLeaveInfoState {}

class SubordinateLeaveInfoSuccess extends SubordinateLeaveInfoState {
  final LeaveInfo leaveData;

  SubordinateLeaveInfoSuccess(this.leaveData);
}

class SubordinateLeaveInfoFailed extends SubordinateLeaveInfoState {
  final String message;

  SubordinateLeaveInfoFailed(this.message);
}
