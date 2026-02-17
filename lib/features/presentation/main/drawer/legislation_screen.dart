import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LegislationScreen extends StatefulWidget {
  const LegislationScreen({Key? key}) : super(key: key);

  @override
  State<LegislationScreen> createState() => _LegislationScreenState();
}

class _LegislationScreenState extends State<LegislationScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(
          "https://www.karabaglar.bel.tr/sayfa/yonetim-semasi-783301"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yönetim Şeması"),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
