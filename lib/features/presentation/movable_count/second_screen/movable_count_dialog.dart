import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/repository/corporate_repository.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/text_field_with_border.dart';
import '../../../../product/constants/app_dimensions.dart';
import '../../../../product/utils/dependency_injection.dart';
import '../../../../product/utils/show_loading_indicator.dart';

import '../../../../product/utils/show_error_message.dart';

class MovableCountDialog extends StatelessWidget {
  const MovableCountDialog({
    Key? key,
    required this.unitId,
    required this.roomId,
    required this.movableName,
    required this.tifDetailId,
    required this.fixtureNo,
    required this.fixtureEkNo,
    required this.movableCodeId,
    required this.comment,
    this.employeeName,
  }) : super(key: key);

  final String unitId;
  final String roomId;
  final String movableName;
  final String tifDetailId;
  final String fixtureNo;
  final String fixtureEkNo;
  final String movableCodeId;
  final String comment;
  final String? employeeName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              style: const TextStyle(
                fontFamily: 'Halyard Display',
                fontSize: 12,
                color: Color(0xff1e1e1e),
                height: 1.8125,
              ),
              children: [
                employeeName != null
                    ? TextSpan(
                        text: "$employeeName isimli personele ait ",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : const TextSpan(),
                TextSpan(
                  text: "$movableName'ın sayımını yapmak istediğinize emin misiniz?",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.mediumGap),
          const TextFieldWithBorder(hintText: 'Taşınır açıklaması'),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: 'İptal Et',
                onPressed: () {
                  context.pop();
                },
              ),
            ),
            const SizedBox(width: AppDimensions.mediumGap),
            Expanded(
              child: AppButton(
                text: 'Ekle',
                onPressed: () {
                  showLoadingIndicator(context);
                  getIt
                      .get<CorporateRepository>()
                      .addMovable(
                        name: movableName,
                        unitId: unitId,
                        fixtureNo: fixtureNo,
                        fixtureEkNo: fixtureEkNo,
                        roomId: roomId,
                        tifDetailId: tifDetailId,
                        fixtureCodeId: fixtureEkNo,
                        comment: comment,
                      )
                      .then(
                    (value) {
                      context.pop();
                      value.fold(
                        (l) => showErrorMessage(l.message),
                        (r) {
                          showSuccessMessage(r);
                          context.pop();
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
