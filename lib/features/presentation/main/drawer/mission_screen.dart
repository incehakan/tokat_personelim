import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../product/constants/app_strings.dart';

class MissionScreen extends StatefulWidget {
  const MissionScreen({Key? key}) : super(key: key);

  @override
  State<MissionScreen> createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
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
        title: const Text("Misyon"),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
