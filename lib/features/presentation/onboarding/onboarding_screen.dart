import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../product/constants/app_dimensions.dart';
import '../../../product/constants/app_images.dart';
import '../../../product/router/app_routes.dart';
import '../../data/repository/cache_repository.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer(
      const Duration(seconds: 2),
      () async {
        final isAuthenticated = CacheRepository.isPhoneVerificated();
        if (isAuthenticated) {
          context.pushReplacementNamed(AppRoutes.main);
        } else {
          context.pushReplacementNamed(AppRoutes.login);
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: Center(
          child: Image.asset(
            AppImages.appLogoBlue,
          ),
        ),
      ),
    );
  }
}
