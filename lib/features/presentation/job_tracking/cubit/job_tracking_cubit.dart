import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../product/constants/app_strings.dart';
import '../../../../product/constants/endpoints.dart';
import '../../../../product/utils/network_manager.dart';

part 'job_tracking_state.dart';

class JobTrackingCubit extends Cubit<JobTrackingState> {
  JobTrackingCubit(this.networkManager) : super(JobTrackingInitial());

  final NetworkManager networkManager;

  Future<void> getLink() async {
    emit(JobTrackingInProgress());
    try {
      final response = await networkManager.get(Endpoints.jobTracking);
      final link = response.data.toString().replaceAll('"', "");
      emit(JobTrackingSuccess(link));
    } on DioException catch (_) {
      emit(JobTrackingFailed(AppStrings.generalErrorMessage));
    }
  }
}
