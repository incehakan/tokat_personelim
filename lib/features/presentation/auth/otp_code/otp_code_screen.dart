import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../../../product/config/app_env.dart';
import '../../../../product/constants/app_dimensions.dart';
import '../../../../product/constants/app_strings.dart';
import '../../../../product/router/app_routes.dart';
import '../../../../product/utils/show_error_message.dart';
import '../../../data/repository/cache_repository.dart';

class OtpCodeScreen extends StatefulWidget {
  const OtpCodeScreen({Key? key, required this.otpCode}) : super(key: key);

  final String otpCode;

  @override
  State<OtpCodeScreen> createState() => _OtpCodeScreenState();
}

class _OtpCodeScreenState extends State<OtpCodeScreen> {
  late TextEditingController _pinController;

  @override
  void initState() {
    _pinController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              AppStrings.otpCodeDescription,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.mediumGap),
            Center(
              child: PinCodeTextField(
                controller: _pinController,
                autofocus: true,
                highlight: true,
                highlightColor: Colors.blue,
                defaultBorderColor: Colors.black,
                maxLength: 6,
                pinBoxWidth: 40,
                pinBoxHeight: 54,
                pinBoxDecoration: ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
                pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 300),
                highlightAnimationBeginColor: Colors.black,
                highlightAnimationEndColor: Colors.white12,
                keyboardType: TextInputType.number,
                onDone: (text) {
                  if (AppEnv.useMock || widget.otpCode == text) {
                    CacheRepository.verificatePhone();
                    context.pushNamed(AppRoutes.main);
                  } else {
                    showErrorMessage(AppStrings.otpCodeError);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
