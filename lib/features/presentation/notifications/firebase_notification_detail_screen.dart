import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../../product/constants/app_dimensions.dart';

class FirebaseNotificationDetailScreen extends StatelessWidget {
  const FirebaseNotificationDetailScreen({Key? key, required this.message}) : super(key: key);

  final RemoteMessage message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          message.notification?.title ?? "",
        ),
      ),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: Text(
          message.notification?.body ?? "",
        ),
      ),
    );
  }
}
