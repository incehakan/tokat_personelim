import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../../../product/constants/app_strings.dart';
import '../../data/repository/cache_repository.dart';
import '../../widgets/loading_indicator.dart';

class PayrollScreen extends StatefulWidget {
  const PayrollScreen({Key? key, required this.payrollUrl}) : super(key: key);

  final String payrollUrl;

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.payroll),
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
