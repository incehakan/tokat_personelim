import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../product/constants/app_dimensions.dart';
import '../../../../product/constants/app_strings.dart';
import '../../../../product/utils/show_error_message.dart';
import '../../../../product/utils/show_loading_indicator.dart';
import '../../../../product/utils/validators.dart';
import '../../../widgets/app_button.dart';
import 'cubit/change_password_cubit.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key, required this.identity, required this.username}) : super(key: key);

  final String identity;
  final String username;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController _pinController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _pinController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.forgotPassword),
      ),
      body: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordInProgress) {
            showLoadingIndicator(context);
          } else if (state is ChangePasswordSuccess) {
            context.pop();
            showSuccessMessage(state.message);
            context.pop();
          } else if (state is ChangePasswordFailed) {
            context.pop();
            showErrorMessage(state.message);
          }
        },
        child: Padding(
          padding: AppDimensions.pagePadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _pinController,
                  validator: (value) => Validators.cannotBlankValidator(value),
                  decoration: const InputDecoration(
                    hintText: "Telefonunuza Gelen Onay Kodu",
                  ),
                ),
                const SizedBox(height: AppDimensions.smallGap),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) => Validators.cannotBlankValidator(value),
                  decoration: const InputDecoration(
                    hintText: "Yeni Şifre",
                  ),
                ),
                const SizedBox(height: AppDimensions.smallGap),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  validator: (value) => Validators.cannotBlankValidator(value),
                  decoration: const InputDecoration(
                    hintText: "Yeni Şifre Tekrar",
                  ),
                ),
                const SizedBox(height: AppDimensions.largeGap),
                AppButton(
                  text: 'Şifremi Sıfırla',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<ChangePasswordCubit>().changePassword(
                            identity: widget.identity,
                            code: _pinController.text,
                            password: _passwordController.text,
                            confirmPassword: _confirmPasswordController.text,
                            username: widget.username,
                          );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
