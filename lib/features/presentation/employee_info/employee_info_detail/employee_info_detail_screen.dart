import 'package:flutter/material.dart';

import '../../../../product/constants/app_strings.dart';
import '../../../data/models/subordinates_model.dart';
import 'tab_screens/subordinate_info/subordinate_info_screen.dart';
import 'tab_screens/subordinate_leave_info/subordinate_leave_info_screen.dart';
import 'tab_screens/subordinate_pdks_info/subordinate_pdks_info_screen.dart';

class EmployeeInfoDetailScreen extends StatefulWidget {
  const EmployeeInfoDetailScreen({Key? key, required this.subordinate}) : super(key: key);

  final Subordinate subordinate;

  @override
  State<EmployeeInfoDetailScreen> createState() => _EmployeeInfoDetailScreenState();
}

class _EmployeeInfoDetailScreenState extends State<EmployeeInfoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.subordinate.adiSoyadi.toString(),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: AppStrings.employeeInfo,
              ),
              Tab(
                text: 'İzin Bilgisi',
              ),
              Tab(
                text: 'PDKS Bilgisi',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SubordinateInfoScreen(
              subordinate: widget.subordinate,
            ),
            SubordinateLeaveInfoScreen(
              subordinate: widget.subordinate,
            ),
            SubordinatePdksInfoScreen(
              subordinate: widget.subordinate,
            )
          ],
        ),
      ),
    );
  }
}
