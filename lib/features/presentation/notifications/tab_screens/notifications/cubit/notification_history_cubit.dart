import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:karabaglarpersonelim/features/data/models/notification.dart';

import '../../../../../data/models/birthday_celebration_model.dart';
import '../../../../../data/repository/notification_repository.dart';

part 'notification_history_state.dart';

class NotificationHistoryCubit extends Cubit<NotificationHistoryState> {
  NotificationHistoryCubit(this.notificationRepository) : super(NotificationHistoryInitial());

  final NotificationRepository notificationRepository;

  Future<void> getNotificationHistory() async {
    emit(NotificationHistoryInProgress());
    final response = await notificationRepository.fetchBirthdayCelebrations();
    response.fold(
      (l) => emit(NotificationHistoryFailed(l.message)),
      (celebrations) async {
        final response = await notificationRepository.fetchNotifications();
        response.fold(
          (l) => emit(NotificationHistoryFailed(l.message)),
          (notifications) => emit(
            NotificationHistorySuccess(celebrations, notifications),
          ),
        );
      },
    );
  }
}
