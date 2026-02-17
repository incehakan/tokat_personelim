import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../product/constants/app_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: LoadingIndicator(
          indicatorType: Indicator.lineScalePulseOut,
          colors: [
            AppColors.sunsetOrange,
            AppColors.kashmirBlue,
            Color(0xff6b7fa0),
          ],
          pathBackgroundColor: Colors.black,
        ),
      ),
    );
  }
}
