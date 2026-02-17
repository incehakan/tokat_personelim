import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../product/constants/app_strings.dart';

class CloudIzmirScreen extends StatefulWidget {
  const CloudIzmirScreen({Key? key}) : super(key: key);

  @override
  State<CloudIzmirScreen> createState() => _CloudIzmirScreenState();
}

class _CloudIzmirScreenState extends State<CloudIzmirScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://bulut.izmir.bel.tr/tr/Account/Login"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.cloudIzmir),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
