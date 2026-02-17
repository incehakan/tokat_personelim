part of 'pdks_info_cubit.dart';

@immutable
class PdksInfoState {}

class PdksInfoInitial extends PdksInfoState {}

class PdksInfoInProgress extends PdksInfoState {}

class PdksInfoSuccess extends PdksInfoState {
  final List<PdksInformation> informations;

  PdksInfoSuccess(this.informations);
}

class PdksInfoFailed extends PdksInfoState {
  final String message;

  PdksInfoFailed(this.message);
}
