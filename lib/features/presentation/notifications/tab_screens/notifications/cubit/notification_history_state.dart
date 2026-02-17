part of 'notification_history_cubit.dart';

@immutable
class NotificationHistoryState {}

class NotificationHistoryInitial extends NotificationHistoryState {}

class NotificationHistoryInProgress extends NotificationHistoryState {}

class NotificationHistorySuccess extends NotificationHistoryState {
  final List<BirthdayCelebration> celebrations;
  final List<PrsNotification> notifications;

  NotificationHistorySuccess(this.celebrations, this.notifications);
}

class NotificationHistoryFailed extends NotificationHistoryState {
  final String message;

  NotificationHistoryFailed(this.message);
}
