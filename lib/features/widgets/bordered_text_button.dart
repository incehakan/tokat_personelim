import 'package:flutter/material.dart';

import '../../product/constants/app_dimensions.dart';

class BorderedTextButton extends StatelessWidget {
  const BorderedTextButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: AppDimensions.buttonRadius,
            side: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Text(text),
    );
  }
}
