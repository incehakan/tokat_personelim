part of 'duties_bloc.dart';

enum DutiesStatus {
  initial,

  /// Kullanıcın konumu alınırken hata oluştuğu durum.
  locationServiceFailed,

  /// Kullanıcının konumuna yakın cihazlar yükleniyor.
  availableDevicesLoading,

  /// Kullanıcının konumuna yakın cihazlar yüklendi.
  availableDevicesSuccess,

  /// Kullanıcının görevlendirmeleri yükleniyor.
  dutiesLoading,

  /// Kullanıcının görevlendirmeleri yüklendi.
  dutiesSuccess,

  /// Kullanıcının görevlendirmeleri yüklenirken hata oluştu.
  dutiesFailed,

  /// Kullanıcının konumu, bir pdks cihazında işlem yapmak için
  /// uygun değil.
  notAvailableDutyOnLocation
}

class DutiesState extends Equatable {
  const DutiesState({
    this.status = DutiesStatus.initial,
    this.statusMessage,
    this.duties = const [],
    this.availableDevices,
  });

  final DutiesStatus status;
  final String? statusMessage;
  final List<PdksDuty> duties;
  final List<DeviceLocation>? availableDevices;

  DutiesState copyWith({
    DutiesStatus? status,
    String? statusMessage,
    List<PdksDuty>? duties,
    List<DeviceLocation>? availableDevices,
  }) {
    return DutiesState(
      status: status ?? this.status,
      statusMessage: statusMessage ?? this.statusMessage,
      duties: duties ?? this.duties,
      availableDevices: availableDevices ?? this.availableDevices,
    );
  }

  @override
  List<Object> get props => [
        status,
        statusMessage ?? "",
        duties,
        availableDevices ?? "",
      ];
}
