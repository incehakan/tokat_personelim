import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../product/config/app_env.dart';
import '../../../../data/repository/auth_repository.dart';
import '../../../../data/repository/cache_repository.dart';
import '../../../../data/repository/firebase_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepository) : super(LoginInitial());

  final AuthRepository authRepository;

  void login(String username, String password) async {
    if (AppEnv.useMock) {
      CacheRepository.setUserCredentials(username, password);
      CacheRepository.verificatePhone();
      emit(LoginSuccess('123456'));
      return;
    }

    emit(LoginInProgress());
    final response = await authRepository.login(
      username,
      password,
    );
    response.fold(
      (l) => emit(LoginFailed(l.message)),
      (r) async {
        final sendOtp = await authRepository.sendOtpCode();
        sendOtp.fold(
          (l) => emit(LoginFailed(l.message)),
          (r) async {
            CacheRepository.setUserCredentials(username, password);
            await FirebaseRepository.sendFCMTokenAfterLogin();
            emit(LoginSuccess(r));
          },
        );
      },
    );
  }
}
