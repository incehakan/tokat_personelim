import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../product/constants/app_colors.dart';
import '../../../product/constants/app_dimensions.dart';
import '../../../product/constants/app_strings.dart';
import '../../../product/extensions/context_extensions.dart';
import '../../../product/router/app_routes.dart';
import '../../../product/utils/network_manager.dart';
import '../../data/models/leave.dart';
import '../../data/models/user_info_model.dart';
import '../../widgets/app_button.dart';
import '../../widgets/custom_error_text.dart';
import '../../widgets/info_screen_header.dart';
import '../../widgets/loading_indicator.dart';
import '../notifications/birthday_popup.dart';
import '../leave/bloc/leaves_bloc.dart';
import '../salary/bloc/salary_bloc.dart';
import 'bloc/profile_bloc.dart';
import 'digital_card_dialog.dart';

part 'profile_screen_items.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileBloc = ProfileBloc(NetworkManager(Dio()));
  final salaryBloc = SalaryBloc(NetworkManager(Dio()));
  final leavesBloc = LeavesBloc(NetworkManager(Dio()));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => profileBloc..add(const GetUserInfo()),
      child: SingleChildScrollView(
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state.status == ProfileStatus.usersBirthday) {
              showDialog(
                  context: context, builder: (ctx) => const BirthdayPopUp());
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case ProfileStatus.initial:
              case ProfileStatus.loading:
                return const Center(
                  child: CustomLoadingIndicator(),
                );
              case ProfileStatus.userInfoFailed:
                return const SizedBox();
              case ProfileStatus.userInfoSuccess:
              case ProfileStatus.usersBirthday:
                return ProfileScreenBody(
                  user: state.userInfo!,
                  salaryBloc: salaryBloc,
                  leavesBloc: leavesBloc,
                );
            }
          },
        ),
      ),
    );
  }
}

class ProfileScreenBody extends StatelessWidget {
  const ProfileScreenBody({
    Key? key,
    required this.user,
    required this.salaryBloc,
    required this.leavesBloc,
  }) : super(key: key);

  final UserInfo user;
  final SalaryBloc salaryBloc;
  final LeavesBloc leavesBloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.pagePadding,
      child: Column(
        children: [
          ProfileCard(user: user),
          const SizedBox(height: AppDimensions.mediumGap),
          LeavesSection(
            leavesBloc: leavesBloc,
          ),
          const SizedBox(height: AppDimensions.mediumGap),
          const InfoScreenHeader(text: AppStrings.salaryInfo),
          SalarySection(salaryBloc: salaryBloc),
        ],
      ),
    );
  }
}

class SalarySection extends StatelessWidget {
  const SalarySection({
    Key? key,
    required this.salaryBloc,
  }) : super(key: key);

  final SalaryBloc salaryBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => salaryBloc..add(GetSalary()),
      child: BlocBuilder<SalaryBloc, SalaryState>(
        builder: (context, state) {
          switch (state.status) {
            case SalaryStatus.initial:
            case SalaryStatus.loading:
              return const CustomLoadingIndicator();
            case SalaryStatus.failure:
              return CustomErrorText(
                message: state.statusMessage,
              );
            case SalaryStatus.success:
              return SizedBox(
                height: 300,
                width: context.width,
                child: Stack(
                  children: [
                    Padding(
                        padding: AppDimensions.pd8,
                        child: LineChart(
                          LineChartData(
                            minX: 0,
                            maxX: 11,
                            minY: 0,
                            maxY: 50000,
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 22,
                                  getTitlesWidget: (value, meta) {
                                    // Yeni yapı: getTitles yerine getTitlesWidget
                                    TextStyle style = const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                    );
                                    switch (value.toInt()) {
                                      case 0:
                                        return Text('Ocak', style: style);
                                      case 2:
                                        return Text('Mart', style: style);
                                      case 4:
                                        return Text('Mayıs', style: style);
                                      case 6:
                                        return Text('Tem.', style: style);
                                      case 8:
                                        return Text('Eylül', style: style);
                                      case 10:
                                        return Text('Kasım', style: style);
                                    }
                                    return const Text('');
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 30,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Üst ve sağ başlıklar kapalı bırakıldı.
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: const FlGridData(
                              show: true,
                              drawVerticalLine: true,
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(
                                color: AppColors.spindle,
                                width: 1,
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: List.generate(
                                  state.salaries!.getRange(0, 11).length,
                                  (index) => FlSpot(
                                    index.toDouble(),
                                    state.salaries![index].netSalary!
                                        .toDouble(),
                                  ),
                                ),
                                isCurved: true,
                                // 'colors' yerine artık 'gradient' veya 'color' kullanılabilir.
                                color: AppColors.sunsetOrange.withOpacity(0.8),
                                barWidth: 5,
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: AppDimensions.buttonRadius,
                        ),
                        child: TextButton(
                          onPressed: () => context.pushNamed(AppRoutes.salary),
                          child: const Text(
                            'İncele',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}

class LeavesSection extends StatelessWidget {
  const LeavesSection({
    Key? key,
    required this.leavesBloc,
  }) : super(key: key);

  final LeavesBloc leavesBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => leavesBloc..add(GetLeaves()),
      child: BlocBuilder<LeavesBloc, LeavesState>(
        builder: (context, state) {
          switch (state.status) {
            case LeaveStatus.initial:
            case LeaveStatus.loading:
              return const Center(
                child: CustomLoadingIndicator(),
              );
            case LeaveStatus.failure:
              return const Center(
                child: Text(AppStrings.generalErrorMessage),
              );
            case LeaveStatus.success:
              return Column(
                children: [
                  const InfoScreenHeader(text: AppStrings.leaveInfo),
                  LeavesCard(leaveInfo: state.leaveInfo!),
                ],
              );
          }
        },
      ),
    );
  }
}

class LeavesCard extends StatelessWidget {
  const LeavesCard({Key? key, required this.leaveInfo}) : super(key: key);

  final LeaveInfo leaveInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDimensions.pd16,
      height: context.height * 0.17,
      decoration: const BoxDecoration(
        color: AppColors.riverBed,
        borderRadius: AppDimensions.cardRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LeaveInfoSection(
                leaveInfo: leaveInfo,
              ),
              TextButton(
                onPressed: () => context.pushNamed(AppRoutes.leave),
                child: const Text('İncele'),
              )
            ],
          ),
          LinearPercentIndicator(
            fillColor: Colors.transparent,
            backgroundColor: Colors.white,
            lineHeight: 30,
            percent: leaveInfo.percentage.toDouble(),
            padding: EdgeInsets.zero,
            barRadius: const Radius.circular(AppDimensions.smallGap),
          ),
        ],
      ),
    );
  }
}

class LeaveInfoSection extends StatelessWidget {
  const LeaveInfoSection({
    Key? key,
    required this.leaveInfo,
  }) : super(key: key);

  final LeaveInfo leaveInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppStrings.usedAnnualLeave} : ${leaveInfo.usedAnnualLeave?.toInt()}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
              ),
        ),
        Text(
          '${AppStrings.remainAnnualLeave} : ${leaveInfo.remainAnnualLeave?.toInt()}',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
              ),
        ),
      ],
    );
  }
}
