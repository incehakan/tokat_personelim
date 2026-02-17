import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../product/constants/app_colors.dart';
import '../../product/constants/app_dimensions.dart';
import '../../product/constants/app_strings.dart';

class CustomErrorText extends StatelessWidget {
  const CustomErrorText({Key? key, this.message}) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Ionicons.warning_outline,
            color: AppColors.riverBed,
            size: 48,
          ),
          const SizedBox(height: AppDimensions.smallGap),
          Text(
            message ?? AppStrings.generalErrorMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.riverBed,
                ),
          ),
        ],
      ),
    );
  }
}
