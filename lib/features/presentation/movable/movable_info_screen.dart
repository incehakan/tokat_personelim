import 'package:flutter/material.dart';
import 'tab_screens/barcode/query_with_barcode_screen.dart';
import 'tab_screens/fixture/query_with_fixture_screen.dart';
import 'tab_screens/serial_number/query_with_serial_number_screen.dart';
import '../../../product/constants/app_dimensions.dart';

class MovableInfoScreen extends StatefulWidget {
  const MovableInfoScreen({Key? key}) : super(key: key);

  @override
  State<MovableInfoScreen> createState() => _MovableInfoScreenState();
}

class _MovableInfoScreenState extends State<MovableInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Taşınır Bilgisi'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Barkod ile Sorgula',
              ),
              Tab(
                text: 'Seri Numarası ile Sorgula',
              ),
              Tab(
                text: 'Demirbaş ile Sorgula',
              ),
            ],
          ),
        ),
        body: const Padding(
          padding: AppDimensions.pagePadding,
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              QueryWithBarcodeScreen(),
              QueryWithSerialNumberScreen(),
              QueryWithFixtureScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
