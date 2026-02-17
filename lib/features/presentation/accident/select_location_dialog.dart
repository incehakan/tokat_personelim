import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../product/utils/determine_position.dart';
import '../../../product/utils/show_error_message.dart';
import '../../../product/utils/show_loading_indicator.dart';
import '../../widgets/app_button.dart';
import 'cubit/accident_cubit.dart';

class SelectLocationDialog extends StatelessWidget {
  const SelectLocationDialog({Key? key, required this.locationController}) : super(key: key);

  final TextEditingController locationController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Olay yerinin şu an ki konumunuz olarak seçilmesini istiyor musunuz?',
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: AppButton(
                text: 'Onayla',
                onPressed: () {
                  showLoadingIndicator(context);
                  getUserPosition().then(
                    (response) {
                      response.fold(
                        (l) {
                          showErrorMessage(l);
                        },
                        (r) {
                          context.read<AccidentCubit>().setLocation(r);
                        },
                      );
                      context.pop();
                      context.pop();
                    },
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AppButton(
                text: 'Kapat',
                onPressed: () => context.pop(),
              ),
            ),
          ],
        )
      ],
    );
  }
}
