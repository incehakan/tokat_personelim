import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/birthday_model.dart';
import '../../../../../data/repository/notification_repository.dart';

part 'birthday_state.dart';

class BirthdayCubit extends Cubit<BirthdayState> {
  BirthdayCubit(this.notificationRepository) : super(BirthdayInitial());

  final NotificationRepository notificationRepository;

  Future<void> getBirthdays() async {
    emit(BirthdayInProgress());
    final response = await notificationRepository.fetchBirthdays();
    response.fold(
      (l) => emit(BirthdayFailed(l.message)),
      (r) {
        final birthdays = r.where((e) => e.tur == 4).toList();
        emit(BirthdaySuccess(birthdays));
      },
    );
  }

  Future<void> celebrateBirthday(String registerNo, String type) async {
    final response = await notificationRepository.celebrateBirthday(registerNo, type);
    response.fold(
      (l) => emit(BirthdayCelebrateFailed(l.message)),
      (r) => emit(BirthdayCelebrateSuccess()),
    );
    getBirthdays();
  }
}
