import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/otp_model.dart';
import '../../../../product/constants/app_strings.dart';
import '../../../../product/constants/endpoints.dart';
import '../../../../product/utils/network_manager.dart';

part 'request_and_complaint_state.dart';

class RequestAndComplaintCubit extends Cubit<RequestAndComplaintState> {
  RequestAndComplaintCubit(this.networkManager) : super(RequestAndComplaintInitial());

  final NetworkManager networkManager;

  Future<void> newRequest(String title, String content) async {
    emit(RequestAndComplaintLoading());

    try {
      final response = await networkManager.post(
        Endpoints.requestAndComplaint,
        data: {
          "KONU": title,
          "ILETI": content,
        },
      );

      final data = OtpModel.fromJson(response.data);

      if (response.statusCode == 200) {
        emit(RequestAndComplaintSuccess(data.message.toString()));
      } else {
        emit(RequestAndComplaintFailed(data.message.toString()));
      }
    } on DioException catch (_) {
      emit(const RequestAndComplaintFailed(AppStrings.generalErrorMessage));
    }
  }
}
