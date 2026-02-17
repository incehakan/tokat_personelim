import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../product/constants/endpoints.dart';
import '../../../../product/utils/network_manager.dart';
import '../../../data/models/user_info_model.dart';
import '../../../data/repository/cache_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.networkManager) : super(const ProfileState()) {
    on<GetUserInfo>((event, emit) => _onGetUserInfo(event, emit));
  }
  final NetworkManager networkManager;

  void _onGetUserInfo(
    GetUserInfo event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));
      final response = await networkManager.get(Endpoints.userInfo);
      final data = UserInfoModel.fromJson(response.data);

      CacheRepository.saveUserInfo(data.userInfo!);

      if (data.userInfo!.isBirthdayToday) {
        emit(state.copyWith(
          status: ProfileStatus.usersBirthday,
          userInfo: data.userInfo,
        ));
      } else {
        emit(state.copyWith(
          status: ProfileStatus.userInfoSuccess,
          userInfo: data.userInfo,
        ));
      }
    } on DioException catch (_) {
      emit(state.copyWith(status: ProfileStatus.userInfoFailed));
    }
  }
}
