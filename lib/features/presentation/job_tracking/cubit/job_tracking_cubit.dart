import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../product/constants/app_strings.dart';
import '../../../../product/constants/endpoints.dart';
import '../../../../product/utils/network_manager.dart';
import '../job_tracking_link.dart';

part 'job_tracking_state.dart';

class JobTrackingCubit extends Cubit<JobTrackingState> {
  JobTrackingCubit(this.networkManager) : super(JobTrackingInitial());

  final NetworkManager networkManager;

  Future<void> getLink() async {
    emit(JobTrackingInProgress());
    try {
      final response = await networkManager.get(Endpoints.jobTracking);
      final link = extractJobTrackingBaseUrl(response.data);
      if (link == null) {
        emit(JobTrackingFailed(AppStrings.jobTrackingLinkUnavailable));
        return;
      }
      emit(JobTrackingSuccess(link));
    } on DioException catch (_) {
      emit(JobTrackingFailed(AppStrings.generalErrorMessage));
    }
  }
}
