import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/app_button.dart';
import '../../../product/constants/app_dimensions.dart';

class BirthdayPopUp extends StatelessWidget {
  const BirthdayPopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: AppDimensions.buttonRadius,
      ),
      content: ClipRRect(
        borderRadius: AppDimensions.buttonRadius,
        child: Image.asset(
          "assets/images/dogumGunuMesaji.jpeg",
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
