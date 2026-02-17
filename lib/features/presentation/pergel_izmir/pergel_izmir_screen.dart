import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../product/constants/app_strings.dart';

class PergelIzmirScreen extends StatefulWidget {
  const PergelIzmirScreen({Key? key}) : super(key: key);

  @override
  State<PergelIzmirScreen> createState() => _PergelIzmirScreenState();
}

class _PergelIzmirScreenState extends State<PergelIzmirScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://pergel.izmir.bel.tr"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.pergelIzmir),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
