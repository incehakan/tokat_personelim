part of 'leaves_bloc.dart';

enum LeaveStatus {
  initial,
  loading,
  success,
  failure,
}

class LeavesState extends Equatable {
  const LeavesState({
    this.status = LeaveStatus.initial,
    this.statusMessage,
    this.leaveInfo,
  });

  final LeaveStatus status;
  final String? statusMessage;
  final LeaveInfo? leaveInfo;

  LeavesState copyWith({
    LeaveStatus? status,
    String? statusMessage,
    LeaveInfo? leaveInfo,
  }) {
    return LeavesState(
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
      leaveInfo: leaveInfo ?? this.leaveInfo,
    );
  }

  @override
  List<Object> get props => [
        status,
        statusMessage ?? "",
        leaveInfo ?? "",
      ];
}
