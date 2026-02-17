import 'package:flutter/material.dart';

import '../../product/constants/app_dimensions.dart';

class RedContainer extends StatelessWidget {
  const RedContainer({Key? key, required this.title, this.info}) : super(key: key);

  final String title;
  final String? info;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: AppDimensions.pd16,
      decoration: BoxDecoration(
        borderRadius: AppDimensions.cardRadius,
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            offset: const Offset(0, 3),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
          ),
          Text(
            info ?? "-",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
          )
        ],
      ),
    );
  }
}
