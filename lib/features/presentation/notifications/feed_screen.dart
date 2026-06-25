import 'package:flutter/material.dart';
import 'package:tokatpersonelim/features/presentation/notifications/tab_screens/flow/feed_screen.dart';

import '../../../product/constants/app_colors.dart';
import '../../../product/constants/app_images.dart';
import 'tab_screens/birthday/birthday_screen.dart';
import 'tab_screens/notifications/notifications_screen.dart';

/// Floating Action Button'a basıldığında gösterilen sayfa
class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            AppImages.appLogo,
            color: AppColors.lynch,
            width: 100,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Akış",
                icon: Icon(Icons.card_giftcard_sharp),
              ),
              Tab(
                text: "Bildirimlerim",
                icon: Icon(Icons.notifications_active_sharp),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FlowScreen(),
            NotificationView(),
          ],
        ),
      ),
    );
  }
}
