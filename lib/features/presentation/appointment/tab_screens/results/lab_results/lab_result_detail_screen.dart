import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../product/constants/app_colors.dart';
import '../../../../../../product/constants/app_dimensions.dart';
import '../../../../../../product/constants/app_strings.dart';
import '../../../../../../product/utils/dependency_injection.dart';
import '../../../../../data/models/lab_result_detail_model.dart';
import '../../../../../data/repository/cache_repository.dart';
import '../../../../../widgets/custom_error_text.dart';
import '../../../../../widgets/info_card_template.dart';
import '../../../../../widgets/loading_indicator.dart';
import 'cubit/lab_result_details_cubit.dart';

class LabResultDetailScreen extends StatefulWidget {
  const LabResultDetailScreen({Key? key, required this.protocolNo}) : super(key: key);

  final String protocolNo;

  @override
  State<LabResultDetailScreen> createState() => _LabResultDetailScreenState();
}

class _LabResultDetailScreenState extends State<LabResultDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.labResults),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<LabResultDetailsCubit>()
          ..getLabResultDetails(
            widget.protocolNo,
            CacheRepository.getPatientNo(),
          ),
        child: Padding(
          padding: AppDimensions.pagePadding,
          child: BlocBuilder<LabResultDetailsCubit, LabResultDetailsState>(
            builder: (context, state) {
              if (state is LabResultDetailsFailed) {
                return Center(child: CustomErrorText(message: state.message));
              } else if (state is LabResultDetailsSuccess) {
                return SuccessBody(
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

class SuccessBody extends StatelessWidget {
  const SuccessBody({Key? key, required this.results}) : super(key: key);

  final List<LabResultDetail> results;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: List.generate(
        results.length,
        (index) => InfoCardTemplate(
          title: results[index].parametreAdi.toString(),
          subtitle: 'Referans Aralığı: ${results[index].referansAraligi}',
          trailing: Text(
            results[index].sonuc.toString(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.kashmirBlue,
                ),
          ),
        ),
      ),
    );
  }
}
