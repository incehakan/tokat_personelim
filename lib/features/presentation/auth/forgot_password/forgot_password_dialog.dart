import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../product/constants/app_dimensions.dart';
import '../../../../product/router/app_routes.dart';
import '../../../../product/utils/dependency_injection.dart';
import '../../../../product/utils/show_error_message.dart';
import '../../../../product/utils/show_loading_indicator.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/text_field_with_border.dart';

class ForgotPasswordDialog extends StatelessWidget {
  const ForgotPasswordDialog({Key? key, required this.usernameController, required this.identityController}) : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController identityController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: AppDimensions.cardRadius,
      ),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFieldWithBorder(
              controller: usernameController,
              hintText: 'Kullanıcı Adı',
            ),
            const SizedBox(height: 10),
            TextFieldWithBorder(
              controller: identityController,
              hintText: 'TC Kimlik Numarası',
            ),
          ],
        ),
      ),
      actions: [
        AppButton(
          text: 'Sms Gönder',
          onPressed: () {
            showLoadingIndicator(context);
            getIt
                .get<AuthRepository>()
                .forgotPasswordCode(
                  usernameController.text,
                  identityController.text,
                )
                .then(
              (value) {
                value.fold((l) {
                  context.pop();
                  showErrorMessage(l.message);
                }, (r) {
                  context.pop();
                  context.pushNamed(
                    AppRoutes.changePassword,
                    extra: [
                      identityController.text,
                      usernameController.text,
                    ],
                  );
                });
              },
            );
          },
        )
      ],
    );
  }
}
