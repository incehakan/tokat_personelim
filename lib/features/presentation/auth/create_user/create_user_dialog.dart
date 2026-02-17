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

class CreateUserDialog extends StatelessWidget {
  const CreateUserDialog({Key? key, required this.identityController}) : super(key: key);

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
              controller: identityController,
              hintText: 'TC Kimlik No',
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      actions: [
        AppButton(
          text: 'Sms Gönder',
          onPressed: () {
            if (identityController.text.isNotEmpty) {
              showLoadingIndicator(context);
              getIt.get<AuthRepository>().createUser(identityController.text).then(
                (value) {
                  value.fold((l) {
                    context.pop();
                    showErrorMessage(l.message);
                  }, (r) {
                    context.pop();
                    showSuccessMessage(r);
                    context.pushNamed(AppRoutes.createUser, extra: identityController.text);
                  });
                },
              );
            }
          },
        )
      ],
    );
  }
}
