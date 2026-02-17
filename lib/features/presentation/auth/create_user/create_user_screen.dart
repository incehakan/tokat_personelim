import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../product/constants/app_dimensions.dart';
import '../../../../product/utils/dependency_injection.dart';
import '../../../../product/utils/show_error_message.dart';
import '../../../../product/utils/show_loading_indicator.dart';
import '../../../../product/utils/validators.dart';
import '../../../widgets/app_button.dart';
import 'cubit/create_user_cubit.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key, required this.identity}) : super(key: key);

  final String identity;

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  late TextEditingController _pinController;
  final _formKey = GlobalKey<FormState>();

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
      appBar: AppBar(
        title: const Text('Kullanıcı Oluştur'),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<CreateUserCubit>(),
        child: BlocListener<CreateUserCubit, CreateUserState>(
          listener: (context, state) {
            if (state is CreateUserInProgress) {
              showLoadingIndicator(context);
            } else if (state is CreateUserFailed) {
              context.pop();
              showErrorMessage(state.message);
            } else if (state is CreateUserSuccess) {
              context.pop();
              showSuccessMessage(state.message);
              context.pop();
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
                  AppButton(
                    text: 'Şifremi Sıfırla',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<CreateUserCubit>().createUserConfirm(
                              widget.identity,
                              _pinController.text,
                            );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
