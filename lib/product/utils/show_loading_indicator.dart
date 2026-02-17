import 'package:flutter/material.dart';

import '../../features/widgets/loading_indicator.dart';

void showLoadingIndicator(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const CustomLoadingIndicator();
    },
  );
}
