import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../product/constants/app_strings.dart';
import '../../../../../../product/router/app_routes.dart';
import '../../../../../../product/utils/dependency_injection.dart';
import '../../../../../data/models/pathology_result_model.dart';
import '../../../../../data/repository/cache_repository.dart';
import '../../../../../widgets/custom_error_text.dart';
import '../../../../../widgets/info_card_template.dart';
import 'cubit/pat_results_cubit.dart';

class PatResultsScreen extends StatefulWidget {
  const PatResultsScreen({Key? key}) : super(key: key);

  @override
  State<PatResultsScreen> createState() => _PatResultsScreenState();
}

class _PatResultsScreenState extends State<PatResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.pathologyResults),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<PatResultsCubit>()
          ..getPathologyResults(
            CacheRepository.getPatientRegistryNo(),
          ),
        child: BlocBuilder<PatResultsCubit, PatResultsState>(
          builder: (context, state) {
            if (state is PatResultsFailed) {
              return Center(child: CustomErrorText(message: state.message));
            } else if (state is PatResultsSuccess) {
              return PatResultsScreenSuccessBody(
                results: state.results,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class PatResultsScreenSuccessBody extends StatelessWidget {
  const PatResultsScreenSuccessBody({Key? key, required this.results}) : super(key: key);

  final List<PathologyResult> results;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        results.length,
        (index) => InfoCardTemplate(
          title: results[index].isteyenBirim.toString(),
          subtitle: 'Tarih: ${results[index].pmGelisTarihi}',
          onTap: () {
            context.pushNamed(
              AppRoutes.patResultDetail,
              extra: results[index].patolojiId,
            );
          },
        ),
      ),
    );
  }
}
