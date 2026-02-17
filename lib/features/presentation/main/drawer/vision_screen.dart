import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../product/constants/app_strings.dart';

class VisionScreen extends StatefulWidget {
  const VisionScreen({Key? key}) : super(key: key);

  @override
  State<VisionScreen> createState() => _VisionScreenState();
}

class _VisionScreenState extends State<VisionScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
          Uri.parse("https://www.karabaglar.bel.tr/sayfa/vizyon-ve-misyon"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.vision),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
