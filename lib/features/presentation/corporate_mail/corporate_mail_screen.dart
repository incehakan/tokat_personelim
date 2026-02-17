import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../product/constants/app_strings.dart';

class CorporateMailScreen extends StatefulWidget {
  const CorporateMailScreen({Key? key}) : super(key: key);

  @override
  State<CorporateMailScreen> createState() => _CorporateMailScreenState();
}

class _CorporateMailScreenState extends State<CorporateMailScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://mail.karabaglar.bel.tr/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.corporateMail),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
