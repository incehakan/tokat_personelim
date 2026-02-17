import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../product/constants/app_dimensions.dart';
import '../../../../../product/constants/app_strings.dart';
import '../../../../../product/router/app_routes.dart';
import '../../../../widgets/info_card_template.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final List<String> menuTitles = [
    AppStrings.labResults,
    AppStrings.pathologyResults,
    AppStrings.viewResults,
  ];

  final List<String> routes = [
    AppRoutes.labResult,
    AppRoutes.patResult,
    AppRoutes.viewResult,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.pagePadding,
      child: Column(
        children: List.generate(
          menuTitles.length,
          (index) => InfoCardTemplate(
            title: menuTitles[index],
            onTap: () => context.pushNamed(routes[index]),
          ),
        ),
      ),
    );
  }
}
