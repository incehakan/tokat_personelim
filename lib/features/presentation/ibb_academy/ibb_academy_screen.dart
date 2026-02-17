import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../product/constants/app_strings.dart';

class AcademyScreen extends StatefulWidget {
  const AcademyScreen({Key? key}) : super(key: key);

  @override
  State<AcademyScreen> createState() => _AcademyScreenState();
}

class _AcademyScreenState extends State<AcademyScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://akademi.izmir.bel.tr/Home/Login"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.ibbAcademy),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
