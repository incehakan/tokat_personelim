import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://www.karabaglar.bel.tr/sayfa/raporlar"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Raporlar"),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
