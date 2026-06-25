import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tokatpersonelim/features/data/models/notification.dart';

import '../../../../../product/constants/app_dimensions.dart';
import '../../widgets/app_button.dart';

class NotificationDetailDialog extends StatelessWidget {
  const NotificationDetailDialog({Key? key, required this.notification}) : super(key: key);

  final PrsNotification notification;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: AppDimensions.cardRadius,
      ),
      title: Text(
        notification.baslik.toString(),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Text(notification.icerik.toString()),
      actions: [
        AppButton(
          text: 'Kapat',
          onPressed: () => context.pop(),
        )
      ],
    );
  }
}
