import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vcard_maintained/vcard_maintained.dart';

import '../../../product/constants/app_colors.dart';
import '../../../product/constants/app_dimensions.dart';
import '../../data/repository/cache_repository.dart';
import '../../widgets/app_button.dart';

class DigitalCardDialog extends StatelessWidget {
  const DigitalCardDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: AppDimensions.cardRadius,
      ),
      content: Text(
        "Cep telefonu numaranız dijital kartınıza eklensin mi?",
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: AppButton(
                text: 'Evet',
                onPressed: () {
                  context.pop();
                  showDigitalCard(context, true);
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: AppButton(
                text: 'Hayır',
                onPressed: () {
                  context.pop();
                  showDigitalCard(context, false);
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

showDigitalCard(BuildContext context, bool phoneAvailable) {
  final employeeInfo = CacheRepository.userInfo();
  return showModalBottomSheet(
    backgroundColor: AppColors.kashmirBlue,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
          var vCard = VCard();
          vCard.firstName = employeeInfo.name.toString();
          vCard.lastName = employeeInfo.surname.toString();
          vCard.organization = 'ESHOT - ${employeeInfo.dutyPlaceName}';
          vCard.cellPhone = phoneAvailable
              ? employeeInfo.phoneNumber.toString().length == 11
                  ? employeeInfo.phoneNumber.toString()
                  : "0${employeeInfo.phoneNumber}"
              : null;
          vCard.workPhone = employeeInfo.numercom.toString().isEmpty
              ? null
              : '0232293${employeeInfo.numercom.toString().length < 4 ? "5000" : employeeInfo.numercom.toString()}';
          vCard.workEmail = employeeInfo.email.toString();
          vCard.role = employeeInfo.title;
          vCard.jobTitle = employeeInfo.title;
          vCard.url = 'https://www.eshot.gov.tr';
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              decoration: const BoxDecoration(
                color: AppColors.kashmirBlue,
                borderRadius: AppDimensions.cardRadius,
              ),
              child: Column(
                children: [
                  const SizedBox(height: AppDimensions.mediumGap),
                  Text(
                    'Dijital Kartım',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: AppDimensions.mediumGap),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: QrImageView(
                          data: vCard.getFormattedString(),
                          version: QrVersions.auto,
                          backgroundColor: Colors.white,
                          size: MediaQuery.of(context).size.height / 4,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
