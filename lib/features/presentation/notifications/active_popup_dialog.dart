import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../product/constants/app_dimensions.dart';
import '../../data/models/popup_model.dart';
import '../../widgets/app_button.dart';

class ActivePopUpDialog extends StatelessWidget {
  const ActivePopUpDialog({Key? key, required this.activePopUp}) : super(key: key);

  final ActivePopUp activePopUp;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: AppDimensions.cardRadius,
      ),
      content: Container(
        child: activePopUp.turId!.round().toString() == "0"
            ? RichText(
                text: TextSpan(
                  text: activePopUp.icerik,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 70,
                textAlign: TextAlign.justify,
              )
            : Image.network(
                activePopUp.icerik.toString(),
              ),
      ),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // CheckboxListTile(
            //   title: const Text(
            //     'Bir daha gösterme',
            //     style: TextStyle(fontSize: 14, color: Color(0xff6b7fa0), fontWeight: FontWeight.w700),
            //   ),
            //   value: checkBoxValue,
            //   onChanged: (value) {
            //     UserInfoStorage.setPopupIcerik(widget.aktifPopup.data!.icerik.toString()).whenComplete(() => Navigator.of(context).pop());
            //   },
            // ),
            AppButton(
              text: 'Kapat',
              onPressed: () => context.pop(),
            )
          ],
        )
      ],
    );
  }
}
