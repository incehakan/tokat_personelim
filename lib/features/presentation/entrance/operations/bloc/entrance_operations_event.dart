part of 'entrance_operations_bloc.dart';

class EntranceOperationsEvent extends Equatable {
  const EntranceOperationsEvent();

  @override
  List<Object> get props => [];
}

// Son giriş çıkış işleminin çekildiği event.
class GetLastEntrance extends EntranceOperationsEvent {
  const GetLastEntrance();

  @override
  List<Object> get props => [];
}

/// Giriş çıkış işlemi için kullanılan event.
///
/// entranceType: İşlem tipi. Eğer kullanıcının son işlemi giriş ise
/// [EntranceType.exit], çıkışsa [EntranceType.entrance] olacak.
///
/// deviceId: İşlemin yapılacak olduğu cihazın id'si.
class MakeEntrance extends EntranceOperationsEvent {
  final EntranceType entranceType;
  final String deviceId;

  const MakeEntrance({
    required this.entranceType,
    required this.deviceId,
  });

  @override
  List<Object> get props => [
        entranceType,
        deviceId,
      ];
}
