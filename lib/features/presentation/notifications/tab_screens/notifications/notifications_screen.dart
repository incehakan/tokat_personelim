import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabaglarpersonelim/features/data/models/notification.dart';
import 'package:karabaglarpersonelim/features/presentation/notifications/birthday_notification_dialog.dart';
import 'package:karabaglarpersonelim/features/presentation/notifications/notification_detail_dialog.dart';

import '../../../../../product/constants/app_dimensions.dart';
import '../../../../../product/utils/dependency_injection.dart';
import '../../../../data/models/birthday_celebration_model.dart';
import '../../../../widgets/custom_error_text.dart';
import '../../../../widgets/info_card_template.dart';
import '../../../../widgets/loading_indicator.dart';
import 'cubit/notification_history_cubit.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bildirimlerim'),
      ),
      body: const NotificationView(),
    );
  }
}

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.pagePadding,
      child: BlocProvider(
        create: (context) =>
            getIt.get<NotificationHistoryCubit>()..getNotificationHistory(),
        child: BlocBuilder<NotificationHistoryCubit, NotificationHistoryState>(
          builder: (context, state) {
            if (state is NotificationHistoryFailed) {
              return Center(
                child: CustomErrorText(message: state.message),
              );
            } else if (state is NotificationHistorySuccess) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Kutlama kartları
                    if (state.celebrations.isNotEmpty)
                      ...List.generate(
                        state.celebrations.length,
                        (index) =>
                            CelebrationCard(celebrations: state.celebrations),
                      ),
                    // Bildirim kartları
                    if (state.notifications.isNotEmpty)
                      ...List.generate(
                        state.notifications.length,
                        (index) => NotificationCard(
                          notification: state.notifications[index],
                        ),
                      ),
                    // Hiç bildirim ya da kutlama yoksa
                    if (state.celebrations.isEmpty &&
                        state.notifications.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text('Henüz bildirim bulunmamaktadır.'),
                        ),
                      ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CustomLoadingIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class CelebrationCard extends StatelessWidget {
  const CelebrationCard({Key? key, required this.celebrations})
      : super(key: key);

  final List<BirthdayCelebration> celebrations;

  @override
  Widget build(BuildContext context) {
    return InfoCardTemplate(
      title: 'Doğum gününüz kutlu olsun !',
      subtitle: '${celebrations.length} kişi kutladı',
      trailing: const Text('Hepsini Gör'),
      onTap: () => showDialog(
        context: context,
        builder: (context) =>
            BirthdayNotificationDialog(celebrations: celebrations),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key, required this.notification})
      : super(key: key);

  final PrsNotification notification;

  @override
  Widget build(BuildContext context) {
    return InfoCardTemplate(
      title: notification.baslik.toString(),
      trailing: const Text('Detay'),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) =>
              NotificationDetailDialog(notification: notification),
        );
      },
    );
  }
}
