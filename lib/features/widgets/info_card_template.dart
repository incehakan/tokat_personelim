import 'package:flutter/material.dart';

import '../../product/constants/app_colors.dart';
import '../../product/constants/app_dimensions.dart';

class InfoCardTemplate extends StatelessWidget {
  const InfoCardTemplate({
    Key? key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.leading,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.mediumGap),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.smallGap),
        decoration: const BoxDecoration(
          borderRadius: AppDimensions.cardRadius,
          color: AppColors.spindle,
          boxShadow: [
            BoxShadow(
              color: AppColors.spindle,
              offset: Offset(0, 4),
              blurRadius: 3,
            ),
          ],
        ),
        child: ListTile(
          leading: leading,
          onTap: () {
            if (onTap != null) {
              onTap!();
            }
          },
          title: Text(
            title,
            style: const TextStyle(
              color: AppColors.lynch,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: const TextStyle(
                    color: AppColors.lynch,
                    fontSize: 12,
                  ),
                )
              : null,
          trailing: trailing ??
              (onTap != null
                  ? const Icon(
                      Icons.chevron_right,
                      color: AppColors.kashmirBlue,
                      size: 28,
                    )
                  : const SizedBox()),
        ),
      ),
    );
  }
}
