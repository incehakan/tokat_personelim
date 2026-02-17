import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../product/constants/app_dimensions.dart';
import '../../data/models/birthday_celebration_model.dart';
import '../../widgets/app_button.dart';

class BirthdayNotificationDialog extends StatelessWidget {
  final List<BirthdayCelebration> celebrations;

  const BirthdayNotificationDialog({Key? key, required this.celebrations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: AppDimensions.cardRadius,
      ),
      title: Text(
        "Doğum Gününüzü Kutlayanlar",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          celebrations.length,
          (index) => ListTile(
            title: Text(celebrations[index].adiSoyadi.toString()),
            subtitle: Text(celebrations[index].gorevYeriAdi.toString()),
          ),
        ),
      ),
      actions: [
        AppButton(
          text: 'Kapat',
          onPressed: () => context.pop(),
        )
      ],
    );
  }
}
