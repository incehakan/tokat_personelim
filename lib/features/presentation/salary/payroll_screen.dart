import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../../../product/constants/app_strings.dart';
import '../../../product/utils/payroll_share_helper.dart';
import '../../../product/utils/show_error_message.dart';
import '../../../product/utils/show_loading_indicator.dart';
import '../../data/repository/cache_repository.dart';
import '../../widgets/loading_indicator.dart';
import 'payroll_share_sheet.dart';

class PayrollScreen extends StatefulWidget {
  const PayrollScreen({Key? key, required this.payrollUrl}) : super(key: key);

  final String payrollUrl;

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  final PayrollShareHelper _shareHelper = PayrollShareHelper(Dio());
  bool _isSharing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.payroll),
        actions: [
          IconButton(
            tooltip: AppStrings.sharePayroll,
            onPressed: _isSharing ? null : _showShareOptions,
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _fetchPayroll(widget.payrollUrl),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          } else {
            return const Center(
              child: CustomLoadingIndicator(),
            );
          }
        },
      ),
    );
  }

  void _showShareOptions() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return PayrollShareSheet(
          onWhatsApp: () => _handleShare(PayrollShareAction.whatsApp),
          onEmail: () => _handleShare(PayrollShareAction.email),
          onSaveToPhone: () => _handleShare(PayrollShareAction.saveToPhone),
        );
      },
    );
  }

  Future<void> _handleShare(PayrollShareAction action) async {
    Navigator.of(context).pop();

    if (_isSharing) {
      return;
    }

    setState(() => _isSharing = true);
    showLoadingIndicator(context);

    try {
      final file = await _shareHelper.downloadPayroll(widget.payrollUrl);
      await _shareHelper.sharePayroll(file, action: action);

      if (!mounted) {
        return;
      }

      Navigator.of(context, rootNavigator: true).pop();

      if (action == PayrollShareAction.saveToPhone) {
        showSuccessMessage(AppStrings.payrollSavedSuccessfully);
      }
    } on PayrollSaveCancelledException {
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    } catch (_) {
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        showErrorMessage(AppStrings.generalErrorMessage);
      }
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }
}

Future<Widget> _fetchPayroll(
  String url,
) async {
  return const PDF(
    swipeHorizontal: true,
  ).cachedFromUrl(
    url,
    headers: {'Authorization': 'Bearer ${CacheRepository.getAccessToken().toString()}'},
  );
}
