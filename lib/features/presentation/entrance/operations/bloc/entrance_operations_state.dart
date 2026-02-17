part of 'entrance_operations_bloc.dart';

enum EntranceOperationsStatus {
  initial,
  // Son yapılmış giriş çıkış işlemlerinin yönetildiği stateler.
  lastEntranceLoading,
  lastEntranceFailed,
  lastEntranceSuccess,

  // Giriş çıkış yapma işlemlerinin yönetildiği stateler.
  entranceOperationInProgress,
  entraneOperationSuccess,
  entranceOperationFailed,
}

/// Kullanıcın yapacağı işlemin giriş mi çıkış mı olacağının kontrolünün
/// yapılacağı enum.
/// Eğer kullanıcının yaptığı son işlem giriş ise [EntranceType] exit, çıkış ise
/// entrance olacak.
enum EntranceType {
  entrance,
  exit,
}

/// 'Şu tarihde "GİRİŞ" işlemi yaptınız, aşagıdaki seçeneklerden "ÇIKIŞ" '
/// yapabilirsiniz textleri bu extension yazılacak.
extension EntranceTypeExtension on EntranceType {
  String get entranceText {
    switch (this) {
      case EntranceType.exit:
        return 'ÇIKIŞ';
      case EntranceType.entrance:
        return 'GİRİŞ';
    }
  }

  String get entranceReverseText {
    switch (this) {
      case EntranceType.exit:
        return 'GİRİŞ';
      case EntranceType.entrance:
        return 'ÇIKIŞ';
    }
  }

  Color get cardColor {
    switch (this) {
      case EntranceType.exit:
        return Colors.green;
      case EntranceType.entrance:
        return Colors.red;
    }
  }
}

class EntranceOperationsState extends Equatable {
  const EntranceOperationsState({
    this.status = EntranceOperationsStatus.initial,
    this.lastEntrance,
    this.entranceType = EntranceType.entrance,
    this.message,
  });

  final EntranceOperationsStatus status;
  final LastEntrance? lastEntrance;
  final EntranceType entranceType;
  final String? message;

  EntranceOperationsState copyWith({
    EntranceOperationsStatus? status,
    LastEntrance? lastEntrance,
    EntranceType? entranceType,
    String? message,
  }) {
    return EntranceOperationsState(
      status: status ?? this.status,
      lastEntrance: lastEntrance ?? this.lastEntrance,
      entranceType: entranceType ?? this.entranceType,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status,
        lastEntrance ?? "",
        entranceType,
        message ?? "",
      ];
}
