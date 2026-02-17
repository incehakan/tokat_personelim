import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ionicons/ionicons.dart';

import '../../../product/constants/app_colors.dart';
import '../../../product/constants/app_dimensions.dart';
import '../../../product/constants/app_strings.dart';
import '../../../product/utils/dependency_injection.dart';
import '../../widgets/custom_error_text.dart';
import '../../widgets/loading_indicator.dart';
import 'cubit/hospital_token_cubit.dart';
import 'tab_screens/appointments/appointments_screen.dart';
import 'tab_screens/make_appointment/make_appointment_screen.dart';
import 'tab_screens/results/results_screen.dart';

part 'appointment_detail_screen_items.dart';

class AppointmentDetailScreen extends StatefulWidget {
  const AppointmentDetailScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentDetailScreen> createState() => _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appointment),
      ),
      body: BlocProvider(
        create: (context) => getIt.get<HospitalTokenCubit>()..getHospitalToken(),
        child: BlocBuilder<HospitalTokenCubit, HospitalTokenState>(
          builder: (context, state) {
            if (state is HospitalTokenFailed) {
              return Center(child: CustomErrorText(message: state.message));
            } else if (state is HospitalTokenSuccess) {
              return AppointmentDetailScreenSuccessBody(
                pageController: _pageController,
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

class AppointmentDetailScreenSuccessBody extends StatelessWidget {
  const AppointmentDetailScreenSuccessBody({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.smallGap),
        AppointmentTabBar(
          pageController: pageController,
        ),
        const SizedBox(height: AppDimensions.smallGap),
        Expanded(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: tabPages,
          ),
        ),
      ],
    );
  }
}
