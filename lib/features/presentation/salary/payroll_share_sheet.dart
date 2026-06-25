import 'package:flutter/material.dart';

import '../../../product/constants/app_dimensions.dart';
import '../../../product/constants/app_strings.dart';

class PayrollShareSheet extends StatelessWidget {
  const PayrollShareSheet({
    Key? key,
    required this.onWhatsApp,
    required this.onEmail,
    required this.onSaveToPhone,
  }) : super(key: key);

  final VoidCallback onWhatsApp;
  final VoidCallback onEmail;
  final VoidCallback onSaveToPhone;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppDimensions.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppStrings.sharePayroll,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.mediumGap),
            _ShareOptionTile(
              icon: Icons.chat,
              iconColor: const Color(0xFF25D366),
              title: AppStrings.shareViaWhatsApp,
              onTap: onWhatsApp,
            ),
            _ShareOptionTile(
              icon: Icons.email_outlined,
              iconColor: Theme.of(context).primaryColor,
              title: AppStrings.shareViaEmail,
              onTap: onEmail,
            ),
            _ShareOptionTile(
              icon: Icons.download_outlined,
              iconColor: Colors.orange,
              title: AppStrings.saveToPhone,
              onTap: onSaveToPhone,
            ),
          ],
        ),
      ),
    );
  }
}

class _ShareOptionTile extends StatelessWidget {
  const _ShareOptionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.12),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
