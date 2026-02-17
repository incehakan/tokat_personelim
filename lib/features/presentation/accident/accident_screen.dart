import 'package:flutter/material.dart';
import 'accident_reports_screen.dart';
import 'new_accident_screen.dart';
import '../../../product/constants/app_dimensions.dart';

class AccidentScreen extends StatefulWidget {
  const AccidentScreen({Key? key}) : super(key: key);

  @override
  State<AccidentScreen> createState() => _AccidentScreenState();
}

class _AccidentScreenState extends State<AccidentScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ramak Kala'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Ramak Kala Formu',
              ),
              Tab(
                text: 'Gönderdiğim Formlar',
              ),
            ],
          ),
        ),
        body: Padding(
          padding: AppDimensions.pagePadding * 1.5,
          child: const TabBarView(
            children: [
              NewAccidentScreen(),
              AccidentReportsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
