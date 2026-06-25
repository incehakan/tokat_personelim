import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widgets/custom_error_text.dart';
import '../../widgets/loading_indicator.dart';

/// Tokat Belediyesi organizasyon şeması:
/// https://tokat.bel.tr/organizasyon-semasi
class OrganizationSchemeScreen extends StatefulWidget {
  const OrganizationSchemeScreen({Key? key}) : super(key: key);

  @override
  State<OrganizationSchemeScreen> createState() => _OrganizationSchemeScreenState();
}

class _OrganizationSchemeScreenState extends State<OrganizationSchemeScreen> {
  static const String _organizationSchemeUrl =
      'https://tokat.bel.tr/organizasyon-semasi';

  late final WebViewController _controller;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (!mounted) return;
            setState(() {
              _isLoading = true;
              _errorMessage = null;
            });
          },
          onPageFinished: (_) {
            if (!mounted) return;
            setState(() {
              _isLoading = false;
              _errorMessage = null;
            });
          },
          onWebResourceError: (error) {
            if (!mounted) return;
            if (error.isForMainFrame != true) return;
            setState(() {
              _isLoading = false;
              _errorMessage = error.description;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(_organizationSchemeUrl));
  }

  void _reload() {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    _controller.loadRequest(Uri.parse(_organizationSchemeUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yönetim Şeması'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reload,
            tooltip: 'Yenile',
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: CustomLoadingIndicator()),
          if (_errorMessage != null)
            Center(
              child: CustomErrorText(
                message: 'Organizasyon şeması yüklenemedi.\n$_errorMessage',
              ),
            ),
        ],
      ),
    );
  }
}
