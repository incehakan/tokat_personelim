import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../data/repository/auth_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.authRepository) : super(ChangePasswordInitial());
  final AuthRepository authRepository;

  Future<void> changePassword({
    required String identity,
    required String code,
    required String password,
    required String confirmPassword,
    required String username,
  }) async {
    emit(ChangePasswordInProgress());
    final response = await authRepository.changePassword(
      identity: identity,
      code: code,
      password: password,
      confirmPassword: confirmPassword,
      username: username,
    );

    response.fold(
      (l) => emit(ChangePasswordFailed(l.message)),
      (r) => emit(ChangePasswordSuccess(r)),
    );
  }
}
