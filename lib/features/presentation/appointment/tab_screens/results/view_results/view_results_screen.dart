import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../product/constants/app_dimensions.dart';
import '../../../../../../product/constants/app_strings.dart';
import '../../../../../../product/router/app_routes.dart';
import '../../../../../../product/utils/dependency_injection.dart';
import '../../../../../data/models/view_result_model.dart';
import '../../../../../data/repository/cache_repository.dart';
import '../../../../../widgets/custom_error_text.dart';
import '../../../../../widgets/info_card_template.dart';
import '../../../../../widgets/loading_indicator.dart';
import 'cubit/view_results_cubit.dart';

class ViewResultsScreen extends StatefulWidget {
  const ViewResultsScreen({Key? key}) : super(key: key);

  @override
  State<ViewResultsScreen> createState() => _ViewResultsScreenState();
}

class _ViewResultsScreenState extends State<ViewResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.viewResults),
      ),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: BlocProvider(
          create: (context) => getIt.get<ViewResultsCubit>()
            ..getViewResults(
              CacheRepository.getPatientRegistryNo(),
            ),
          child: BlocBuilder<ViewResultsCubit, ViewResultsState>(
            builder: (context, state) {
              if (state is ViewResultsFailed) {
                return Center(child: CustomErrorText(message: state.message));
              } else if (state is ViewResultsSuccess) {
                return ViewResultsScreenSuccessBody(
                  results: state.results,
                );
              } else {
                return const Center(
                  child: CustomLoadingIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class ViewResultsScreenSuccessBody extends StatelessWidget {
  const ViewResultsScreenSuccessBody({Key? key, required this.results}) : super(key: key);

  final List<ViewResult> results;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        results.length,
        (index) => InfoCardTemplate(
          title: results[index].tetkikAdi.toString(),
          subtitle: 'Tarih: ${results[index].pmGelisTarihi.toString()}',
          onTap: () => context.pushNamed(
            AppRoutes.viewResultDetail,
            extra: results[index].sonuc,
          ),
        ),
      ),
    );
  }
}
