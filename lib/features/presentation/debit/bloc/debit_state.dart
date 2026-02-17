part of 'debit_bloc.dart';

enum DebitStatus {
  initial,
  loading,
  success,
  failure,
}

class DebitState extends Equatable {
  const DebitState({
    this.status = DebitStatus.initial,
    this.debitInfo,
    this.statusMessage,
  });

  final DebitStatus status;
  final DebitInfo? debitInfo;
  final String? statusMessage;

  DebitState copyWith({
    DebitStatus? status,
    DebitInfo? debitInfo,
    String? statusMessage,
  }) {
    return DebitState(
      status: status ?? this.status,
      debitInfo: debitInfo ?? this.debitInfo,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        debitInfo ?? "",
        statusMessage ?? "",
      ];
}
