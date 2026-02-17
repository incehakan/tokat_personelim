import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../product/constants/app_strings.dart';
import '../../../../../../product/utils/dependency_injection.dart';
import '../../../../../data/repository/cache_repository.dart';
import '../../../../../widgets/custom_error_text.dart';
import '../../../../../widgets/info_card_template.dart';
import 'cubit/pat_result_detail_cubit.dart';

class PatResultDetailScreen extends StatefulWidget {
  const PatResultDetailScreen({Key? key, required this.pathologyId}) : super(key: key);

  final String pathologyId;

  @override
  State<PatResultDetailScreen> createState() => _PatResultDetailScreenState();
}

class _PatResultDetailScreenState extends State<PatResultDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.pathologyResults),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<PatResultDetailCubit>()
          ..getPatResultDetail(
            widget.pathologyId,
            CacheRepository.getPatientNo(),
          ),
        child: BlocBuilder<PatResultDetailCubit, PatResultDetailState>(
          builder: (context, state) {
            if (state is PatResultDetailFailed) {
              return Center(child: CustomErrorText(message: state.message));
            } else if (state is PatResultDetailSuccess) {
              return ListView(
                shrinkWrap: true,
                children: List.generate(
                  state.results.length,
                  (index) => InfoCardTemplate(
                    title: state.results[index].result.toString(),
                    trailing: const SizedBox(),
                  ),
                ),
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
