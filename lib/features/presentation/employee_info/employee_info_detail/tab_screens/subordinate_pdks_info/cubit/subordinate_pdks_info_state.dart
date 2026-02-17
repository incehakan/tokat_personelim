part of 'subordinate_pdks_info_cubit.dart';

@immutable
class SubordinatePdksInfoState {}

class SubordinatePdksInfoInitial extends SubordinatePdksInfoState {}

class SubordinatePdksInfoInProgress extends SubordinatePdksInfoState {}

class SubordinatePdksInfoSuccess extends SubordinatePdksInfoState {
  final List<SubordinatePdksInfo> pdksInfos;

  SubordinatePdksInfoSuccess(this.pdksInfos);
}

class SubordinatePdksInfoFailed extends SubordinatePdksInfoState {
  final String message;

  SubordinatePdksInfoFailed(this.message);
}
