import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../product/constants/app_colors.dart';
import '../../../../../../product/constants/app_dimensions.dart';
import '../../../../../../product/constants/app_strings.dart';
import '../../../../../../product/router/app_routes.dart';
import '../../../../../../product/utils/dependency_injection.dart';
import '../../../../../data/models/lab_result_model.dart';
import '../../../../../data/repository/cache_repository.dart';
import '../../../../../widgets/custom_error_text.dart';
import '../../../../../widgets/info_card_template.dart';
import '../../../../../widgets/loading_indicator.dart';
import 'cubit/lab_results_cubit.dart';

class LabResultsScreen extends StatefulWidget {
  const LabResultsScreen({Key? key}) : super(key: key);

  @override
  State<LabResultsScreen> createState() => _LabResultsScreenState();
}

class _LabResultsScreenState extends State<LabResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.labResults),
      ),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: BlocProvider(
          create: (context) => getIt.get<LabResultsCubit>()
            ..getLabResults(
              CacheRepository.getPatientRegistryNo(),
            ),
          child: BlocBuilder<LabResultsCubit, LabResultsState>(
            builder: (context, state) {
              if (state is LabResultsFailed) {
                return Center(child: CustomErrorText(message: state.message));
              } else if (state is LabResultsSuccess) {
                return LabResultsScreenSuccessBody(
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

class LabResultsScreenSuccessBody extends StatelessWidget {
  const LabResultsScreenSuccessBody({Key? key, required this.results}) : super(key: key);

  final List<LabResult> results;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        results.length,
        (index) => InfoCardTemplate(
          title: results[index].isteyenBirim.toString(),
          subtitle: 'Tarih: ${results[index].pmGelisTarihi.toString()}',
          trailing: const Icon(
            Icons.search,
            color: AppColors.kashmirBlue,
          ),
          onTap: () => context.pushNamed(
            AppRoutes.labResultDetail,
            extra: results[index].protokolNo,
          ),
        ),
      ),
    );
  }
}
