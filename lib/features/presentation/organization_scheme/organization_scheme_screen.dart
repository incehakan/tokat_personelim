import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../../../product/constants/app_strings.dart';
import '../../../product/constants/endpoints.dart';
import '../../data/repository/cache_repository.dart';
import '../../widgets/loading_indicator.dart';

class OrganizationSchemeScreen extends StatefulWidget {
  const OrganizationSchemeScreen({Key? key}) : super(key: key);

  @override
  State<OrganizationSchemeScreen> createState() => _OrganizationSchemeScreenState();
}

class _OrganizationSchemeScreenState extends State<OrganizationSchemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.organizationScheme),
      ),
      body: FutureBuilder(
        future: fetchOrganizationScheme(),
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

  Future<Widget> fetchOrganizationScheme() async {
    const url = Endpoints.baseUrl + Endpoints.organizationScheme;
    final headers = {
      'Authorization': 'Bearer ${CacheRepository.getAccessToken()}',
    };
    const PDF(
      swipeHorizontal: true,
    ).cachedFromUrl(url, headers: headers);
    return const PDF(
      swipeHorizontal: true,
    ).cachedFromUrl(url, headers: headers);
  }
}
