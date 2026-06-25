import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../product/constants/app_strings.dart';
import '../../../../../product/constants/endpoints.dart';
import '../../../../../product/utils/api_error_helper.dart';
import '../../../../../product/utils/network_manager.dart';
import '../../../../data/models/driver_hours_model.dart';

part 'driver_hours_event.dart';
part 'driver_hours_state.dart';

class DriverHoursBloc extends Bloc<DriverHoursEvent, DriverHoursState> {
  DriverHoursBloc(this.networkManager) : super(const DriverHoursState()) {
    on<GetDriverHours>((event, emit) => _onGetDriverHours(event, emit));
  }

  final NetworkManager networkManager;

  Future<void> _onGetDriverHours(
    GetDriverHours event,
    Emitter<DriverHoursState> emit,
  ) async {
    emit(state.copyWith(status: DriverHoursStatus.loading));
    try {
      final date =
          "${event.date.day.toString().padLeft(2, "0")}.${event.date.month.toString().padLeft(2, "0")}.${event.date.year.toString().padLeft(2, "0")}";
      final response = await networkManager.get(
        Endpoints.driverHours,
        queryParameters: {
          'tarih': date,
        },
      );
      final data = DriverHoursModel.fromJson(response.data);
      final hasTrips = data.seferListe != null && data.seferListe!.isNotEmpty;
      final successCode = data.sonucKodu == null || data.sonucKodu == 0;

      if (hasTrips && successCode) {
        emit(state.copyWith(
          status: DriverHoursStatus.success,
          driverHours: data.seferListe,
        ));
        return;
      }

      emit(state.copyWith(
        status: DriverHoursStatus.failure,
        statusMessage: sanitizeServerMessage(
          data.sonucMesaj,
          fallback: AppStrings.generalErrorMessage,
        ),
      ));
    } on DioException catch (err) {
      emit(state.copyWith(
        status: DriverHoursStatus.failure,
        statusMessage: sanitizeServerMessage(
          parseApiErrorMessage(err),
          fallback: AppStrings.generalErrorMessage,
        ),
      ));
    }
  }
}
