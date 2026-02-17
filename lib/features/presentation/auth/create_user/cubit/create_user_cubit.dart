import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../data/repository/auth_repository.dart';

part 'create_user_state.dart';

class CreateUserCubit extends Cubit<CreateUserState> {
  CreateUserCubit(this.authRepository) : super(CreateUserInitial());

  final AuthRepository authRepository;

  Future<void> createUserConfirm(String identity, String code) async {
    emit(CreateUserInProgress());
    final response = await authRepository.createUserConfirmRequest(
      identity,
      code,
    );
    response.fold(
      (l) => emit(CreateUserFailed(l.message)),
      (r) => emit(CreateUserSuccess(r)),
    );
  }
}
