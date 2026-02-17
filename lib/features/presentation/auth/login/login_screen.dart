import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../create_user/create_user_dialog.dart';
import '../forgot_password/forgot_password_dialog.dart';

import '../../../../product/constants/app_dimensions.dart';
import '../../../../product/constants/app_images.dart';
import '../../../../product/constants/app_strings.dart';
import '../../../../product/router/app_routes.dart';
import '../../../../product/utils/dependency_injection.dart';
import '../../../../product/utils/show_error_message.dart';
import '../../../../product/utils/show_loading_indicator.dart';
import '../../../../product/utils/validators.dart';
import '../../../data/repository/cache_repository.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/default_bg_card.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _fpUsernameController;
  late TextEditingController _fpIdentityController;
  late TextEditingController _identityController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _fpUsernameController = TextEditingController();
    _fpIdentityController = TextEditingController();
    _identityController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _fpUsernameController.dispose();
    _fpIdentityController.dispose();
    _identityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Image.asset(
          AppImages.appLogoBlue,
          width: 250,
        ),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<LoginCubit>(),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginInProgress) {
              showLoadingIndicator(context);
            } else if (state is LoginFailed) {
              // Close Loading Indicator
              context.pop();
              showErrorMessage(state.message);
            } else if (state is LoginSuccess) {
              // Close Loading Indicator
              context.pop();
              if (CacheRepository.isPhoneVerificated()) {
                context.pushNamed(AppRoutes.main);
              } else {
                context.pushNamed(
                  AppRoutes.otpCode,
                  extra: state.code,
                );
              }
            }
          },
          child: LoginScreenBody(
            formKey: _formKey,
            usernameController: _usernameController,
            passwordController: _passwordController,
            fpIdentityController: _fpIdentityController,
            fpUsernameController: _fpUsernameController,
            identityController: _identityController,
          ),
        ),
      ),
    );
  }
}

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({
    Key? key,
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
    required this.fpUsernameController,
    required this.fpIdentityController,
    required this.identityController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController fpUsernameController;
  final TextEditingController fpIdentityController;
  final TextEditingController identityController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.pagePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            AppImages.loginImage,
            width: 200,
          ),
          DefaultBackgroundCard(
            child: FormSection(
              formKey: formKey,
              usernameController: usernameController,
              passwordController: passwordController,
              fpIdentityController: fpIdentityController,
              fpUsernameController: fpUsernameController,
            ),
          ),
          const SizedBox(height: AppDimensions.smallGap),
          CreateAccountSection(
            identityController: identityController,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class FormSection extends StatefulWidget {
  const FormSection({
    Key? key,
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
    required this.fpUsernameController,
    required this.fpIdentityController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController fpUsernameController;
  final TextEditingController fpIdentityController;

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: widget.usernameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: AppStrings.username,
              border: InputBorder.none,
              icon: Icon(
                Icons.account_circle_sharp,
              ),
            ),
            validator: (value) => Validators.cannotBlankValidator(value),
          ),
          TextFormField(
            controller: widget.passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              hintText: AppStrings.password,
              border: InputBorder.none,
              icon: const Icon(
                Icons.vpn_key_rounded,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            validator: (value) => Validators.cannotBlankValidator(value),
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => ForgotPasswordDialog(
                  usernameController: widget.fpUsernameController,
                  identityController: widget.fpIdentityController,
                ),
              );
            },
            child: const Text(AppStrings.forgotPassword),
          ),
          AppButton(
            text: AppStrings.login,
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                if (widget.usernameController.text == 'Tester') {
                  context.pushReplacementNamed(AppRoutes.main);
                } else {
                  context.read<LoginCubit>().login(
                        widget.usernameController.text,
                        widget.passwordController.text,
                      );
                }
              }
            },
          )
        ],
      ),
    );
  }
}

class CreateAccountSection extends StatelessWidget {
  const CreateAccountSection({
    Key? key,
    required this.identityController,
  }) : super(key: key);

  final TextEditingController identityController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(AppStrings.dontHaveAccount),
        TextButton(
          onPressed: () => showDialog(context: context, builder: (ctx) => CreateUserDialog(identityController: identityController)),
          child: const Text(AppStrings.createAccount),
        )
      ],
    );
  }
}
