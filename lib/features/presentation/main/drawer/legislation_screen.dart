import 'package:flutter/material.dart';

import '../../organization_scheme/organization_scheme_screen.dart';

/// Yan menüdeki "Yönetim Şeması" artık kurum API'sinden PDF gösterir.
/// Eski WebView (tokat.bel.tr) emülatörde ve bazı ağlarda bağlantı hatası veriyordu.
@Deprecated('AppRoutes.organizationScheme kullanın')
class LegislationScreen extends StatelessWidget {
  const LegislationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const OrganizationSchemeScreen();
  }
}
