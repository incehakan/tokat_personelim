import 'package:flutter/material.dart';

import '../../product/constants/app_dimensions.dart';

/// Login Ekranında kullanılan form arkaplanı. Muhtemelen birkaç yerde
/// daha kullanılacak.
class DefaultBackgroundCard extends StatelessWidget {
  const DefaultBackgroundCard({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDimensions.pd16,
      decoration: const BoxDecoration(
        borderRadius: AppDimensions.cardRadius,
        color: Color.fromRGBO(255, 255, 255, 0.85),
        boxShadow: [
          BoxShadow(
            color: Color(0x2401274c),
            offset: Offset(0, 8),
            blurRadius: 20,
          )
        ],
      ),
      child: child,
    );
  }
}
