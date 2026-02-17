import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../product/constants/app_colors.dart';
import '../../../product/constants/app_dimensions.dart';
import '../../../product/constants/app_images.dart';
import '../../../product/constants/app_strings.dart';
import '../../../product/extensions/context_extensions.dart';
import '../../../product/router/app_routes.dart';
import '../../../product/utils/dependency_injection.dart';
import '../../data/models/employee_relative_model.dart';
import '../../data/repository/cache_repository.dart';
import '../../widgets/custom_error_text.dart';
import '../../widgets/info_card_template.dart';
import '../../widgets/loading_indicator.dart';
import 'cubit/relative_cubit.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appointment),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<RelativeCubit>()..getRelatives(),
        child: BlocBuilder<RelativeCubit, RelativeState>(
          builder: (context, state) {
            if (state is RelativeFailed) {
              return Center(child: CustomErrorText(message: state.message));
            } else if (state is RelativeSuccess) {
              return AppointmentScreenSuccessBody(
                relatives: state.relatives,
              );
            } else {
              return const Center(
                child: CustomLoadingIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class AppointmentScreenSuccessBody extends StatelessWidget {
  const AppointmentScreenSuccessBody({Key? key, required this.relatives}) : super(key: key);

  final List<Relative> relatives;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppDimensions.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.hospitalImage,
              height: context.height * 0.3,
            ),
            const SizedBox(height: AppDimensions.mediumGap),
            Text(
              AppStrings.appointmentTitle,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.lynch,
                  ),
            ),
            const SizedBox(height: AppDimensions.mediumGap),
            Padding(
              padding: AppDimensions.pd8,
              child: Column(
                children: List.generate(
                  relatives.length,
                  (index) => RelativeCard(
                    relative: relatives[index],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RelativeCard extends StatelessWidget {
  const RelativeCard({Key? key, required this.relative}) : super(key: key);

  final Relative relative;

  @override
  Widget build(BuildContext context) {
    return InfoCardTemplate(
      title: relative.fullName.toString(),
      subtitle: relative.relativeDegree.toString(),
      onTap: () {
        CacheRepository.setPatientRegistryNo(
          relative.registryNo!.toInt().toString(),
        );
        context.pushNamed(
          AppRoutes.appointmentDetail,
          extra: relative.registryNo!.toInt().toString(),
        );
      },
    );
  }
}
