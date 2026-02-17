import 'package:flutter/material.dart';

import '../../../../../../product/constants/app_dimensions.dart';
import '../../../../../../product/constants/app_strings.dart';
import '../../../../../widgets/info_card_template.dart';

class ViewResultDetailScreen extends StatefulWidget {
  const ViewResultDetailScreen({Key? key, required this.result}) : super(key: key);

  final String result;

  @override
  State<ViewResultDetailScreen> createState() => _ViewResultDetailScreenState();
}

class _ViewResultDetailScreenState extends State<ViewResultDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.viewResults),
      ),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: InfoCardTemplate(
          title: widget.result,
          trailing: const SizedBox(),
        ),
      ),
    );
  }
}
