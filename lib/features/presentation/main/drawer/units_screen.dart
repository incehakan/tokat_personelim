import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../product/constants/app_strings.dart';

class UnitsScreen extends StatefulWidget {
  const UnitsScreen({Key? key}) : super(key: key);

  @override
  State<UnitsScreen> createState() => _UnitsScreenState();
}

class _UnitsScreenState extends State<UnitsScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
          Uri.parse("https://www.karabaglar.bel.tr/sayfa/mudurlukler"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.units),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
