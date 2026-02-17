part of 'subordinate_info_cubit.dart';

@immutable
class SubordinateInfoState {}

class SubordinateInfoInitial extends SubordinateInfoState {}

class SubordinateInfoInProgress extends SubordinateInfoState {}

class SubordinateInfoSuccess extends SubordinateInfoState {
  final UserInfo employeeInfo;

  SubordinateInfoSuccess(this.employeeInfo);
}

class SubordinateInfoFailed extends SubordinateInfoState {
  final String message;

  SubordinateInfoFailed(this.message);
}
