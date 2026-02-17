import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../product/constants/app_dimensions.dart';
import '../../../product/router/app_routes.dart';
import '../../../product/utils/dependency_injection.dart';
import '../../../product/utils/show_error_message.dart';
import '../../data/models/confirmation_document_model.dart';
import '../../widgets/app_button.dart';
import '../../widgets/custom_error_text.dart';
import '../../widgets/loading_indicator.dart';
import 'cubit/confirmation_document_cubit.dart';

class PdksConfirmationScreen extends StatefulWidget {
  const PdksConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<PdksConfirmationScreen> createState() => _PdksConfirmationScreenState();
}

class _PdksConfirmationScreenState extends State<PdksConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDKS Bilgilerim'),
      ),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: BlocProvider(
          create: (context) => getIt.get<ConfirmationDocumentCubit>()..getConfirmationDocument(),
          child: BlocConsumer<ConfirmationDocumentCubit, ConfirmationDocumentState>(
            listener: (context, state) {
              if (state is ConfirmationDocumentAccepted) {
                context.pushReplacementNamed(AppRoutes.entrance);
              } else if (state is ConfirmationDocumentConfirmSuccess) {
                context.pushReplacementNamed(AppRoutes.entrance);
              } else if (state is ConfirmationDocumentConfirmFailed) {
                showErrorMessage(state.message);
              }
            },
            builder: (context, state) {
              if (state is ConfirmationDocumentFailed) {
                return CustomErrorText(message: state.message);
              } else if (state is ConfirmationDocumentSuccess) {
                return SuccessBody(
                  document: state.document,
                );
              } else {
                return const Center(
                  child: CustomLoadingIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class SuccessBody extends StatelessWidget {
  const SuccessBody({Key? key, required this.document}) : super(key: key);

  final ConfirmationDocument document;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            document.baslik.toString(),
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            document.icerik.toString(),
            textAlign: TextAlign.justify,
          ),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Okudum anladım, onaylıyorum.',
            ),
            value: false,
            onChanged: (value) {},
          ),
          AppButton(
            text: 'Onayla',
            onPressed: () => context.read<ConfirmationDocumentCubit>().confirmDocument(
                  document.id.toString(),
                ),
          ), //Checkbox
        ],
      ),
    );
  }
}
