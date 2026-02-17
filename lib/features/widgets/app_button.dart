import 'package:flutter/material.dart';

import '../../product/constants/app_dimensions.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isActive = true,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (isActive) {
            onPressed();
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
            isActive ? Theme.of(context).primaryColor : Colors.grey,
          ),
          foregroundColor: const MaterialStatePropertyAll<Color>(
            Colors.white,
          ),
          shape: const MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: AppDimensions.buttonRadius,
            ),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}

class WhiteAppButton extends StatelessWidget {
  const WhiteAppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isActive = true,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (isActive) {
            onPressed();
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
            isActive ? Colors.white : Colors.grey,
          ),
          foregroundColor: MaterialStatePropertyAll<Color>(
            Theme.of(context).primaryColor,
          ),
          shape: const MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: AppDimensions.buttonRadius,
            ),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
    );
  }
}
