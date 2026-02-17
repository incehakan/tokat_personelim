import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../../product/utils/determine_position.dart';
import '../../../../../product/utils/network_manager.dart';
import '../../../../data/models/device_location_model.dart';
import '../../../../data/models/pdks_duty_model.dart';

part 'duties_event.dart';
part 'duties_state.dart';

class DutiesBloc extends Bloc<DutiesEvent, DutiesState> {
  DutiesBloc(this.networkManager) : super(const DutiesState()) {
    on<GetAvailableDeviceLocations>((event, emit) => _onGetAvailableDeviceLocations(event, emit));
    on<GetAvailableDuties>((event, emit) => _onGetAvailableDuties(event, emit));
  }

  final NetworkManager networkManager;

  /// Önce, kullanıcının konumu alınıyor. Eğer kullanıcının konumu alınamazsa
  /// status [DutiesStatus.locationServiceFailed] olarak set ediliyor ve işlem
  /// bitiyor.
  /// Eğer konum alınırsa önce, kullanıcının yakınlarında işlem yapabileceği
  /// bir PDKS cihazı var mı diye bakılıyor. Eğer yakınlarda işlem yapabileceği
  /// bir cihaz carsa status [DutiesStatus.availableDevicesSuccess] olarak
  /// set ediliyor ve işlem bitiyor.
  /// Eğer, konumuna yakın bir PDKS cihazı yoksa kullanıcının üzerine açılmış
  /// bir görevlendirme var mı diye bakılıyor. [_onGetAvailableDuties]
  Future<void> _onGetAvailableDeviceLocations(
    GetAvailableDeviceLocations event,
    Emitter<DutiesState> emit,
  ) async {
    emit(state.copyWith(status: DutiesStatus.availableDevicesLoading));
    final position = await getUserPosition();
    position.fold(
      (l) => emit(state.copyWith(
        status: DutiesStatus.locationServiceFailed,
        statusMessage: l,
      )),
      (r) async {
        try {
          final availableDevices = await _fetchAvailableDevices(r);
          if (availableDevices != null && availableDevices.isNotEmpty) {
            emit(state.copyWith(
              status: DutiesStatus.availableDevicesSuccess,
              availableDevices: availableDevices,
            ));
          } else {
            add(const GetAvailableDuties());
          }
        } on DioException catch (_) {
          add(const GetAvailableDuties());
        }
      },
    );
  }

  /// Kullanıcının üzerinde görevlendirme oluğ olmadığının kontrolünün
  /// yapıldığı fonksiyon. Eğer, kullanıcının üzerinde bir görevlendirme varsa
  /// status [DutiesStatus.dutiesSuccess] olarak set ediliyor.
  /// Eğer, görevlendirme varsa ama kullanıcının konumu işlem yapabileceği
  /// PDKS cihazının yakınlarında değilse status [DutiesStatus.notAvailableDutyOnLocation]
  /// olarak set ediliyor ve kullanıcıya, PDKS cihazlarının konumları gösteriliyor.
  Future<void> _onGetAvailableDuties(
    GetAvailableDuties event,
    Emitter<DutiesState> emit,
  ) async {
    emit(state.copyWith(status: DutiesStatus.dutiesLoading));

    try {
      final response = await _fetchDuties();
      if (response.code == 0) {
        emit(state.copyWith(
          status: DutiesStatus.dutiesSuccess,
          duties: response.duties,
        ));
      } else {
        emit(state.copyWith(
          status: DutiesStatus.dutiesFailed,
          duties: response.duties,
          statusMessage: response.message.toString(),
        ));
      }
    } on DioException catch (e) {
      emit(state.copyWith(
        status: DutiesStatus.notAvailableDutyOnLocation,
        statusMessage: e.response!.statusMessage,
      ));
    }
  }

  /// Kullanıcının konumunun yakınlarında işlem yapabileceği uygun bir cihaz
  /// var mı sorusuna cevap veren o fonksiyon işte bu fonksiyon.
  ///
  Future<List<DeviceLocation>?> _fetchAvailableDevices(Position position) async {
    // Akışı takip ederken url'in burada olması şimdilik daha çok işime geliyo.
    // Takip etmeyi kolaylaştırıyor, kalsın.
    const path = '/api/prs/PersonelPdksUygunLokasyonGetir';
    try {
      final request = await networkManager.post(
        path,
        data: {
          "KOORDINAT_X": position.latitude.toString(),
          "KOORDINAT_Y": position.longitude.toString(),
        },
      );
      final response = AvailableDeviceLocationResponse.fromJson(request.data);
      final availableDevices = response.locations;
      return availableDevices;
    } on DioException catch (_) {
      rethrow;
    }
  }

  /// Kullanıcıya ait görevlendirme olup olmadığını kontrol ettiğimiz fonskiyon.
  Future<PdksDutyModel> _fetchDuties() async {
    const path = '/api/prs/PersonelPdksGorevLokasyonGetir';
    try {
      final response = await networkManager.post(path);
      final data = PdksDutyModel.fromJson(response.data);
      return data;
    } on DioException catch (_) {
      rethrow;
    }
  }
}
