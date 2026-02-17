import 'package:flutter/material.dart';

import '../../product/constants/app_colors.dart';
import '../../product/constants/app_dimensions.dart';
import '../../product/extensions/context_extensions.dart';

class InfoScreenHeader extends StatelessWidget {
  const InfoScreenHeader({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.largeGap),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.lynch,
                fontWeight: FontWeight.w500,
              ),
        ),
        SizedBox(
          width: context.width * 0.5,
          child: const Divider(),
        ),
        const SizedBox(height: AppDimensions.mediumGap),
      ],
    );
  }
}
