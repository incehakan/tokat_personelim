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
import '../../data/models/salary.dart';
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

List<Salary> _salariesForChart(List<Salary>? salaries) {
  if (salaries == null || salaries.isEmpty) {
    return [];
  }
  final sorted = List<Salary>.from(salaries)
    ..sort((a, b) {
      final yearCompare = (a.payrollYear ?? 0).compareTo(b.payrollYear ?? 0);
      if (yearCompare != 0) {
        return yearCompare;
      }
      return (a.payrollMonth ?? 0).compareTo(b.payrollMonth ?? 0);
    });
  if (sorted.length <= 12) {
    return sorted;
  }
  return sorted.sublist(sorted.length - 12);
}

String _monthLabel(Salary salary) {
  const monthNames = <String>[
    '',
    'Oca',
    'Şub',
    'Mar',
    'Nis',
    'May',
    'Haz',
    'Tem',
    'Ağu',
    'Eyl',
    'Eki',
    'Kas',
    'Ara',
  ];
  final month = salary.payrollMonth?.toInt();
  if (month != null && month >= 1 && month <= 12) {
    return monthNames[month];
  }
  final text = salary.month?.trim();
  if (text != null && text.isNotEmpty) {
    return text.length > 5 ? text.substring(0, 5) : text;
  }
  return '';
}

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
              final chartSalaries = _salariesForChart(state.salaries);
              if (chartSalaries.isEmpty) {
                return const CustomErrorText(
                  message: 'Gösterilecek maaş kaydı bulunamadı.',
                );
              }
              final spots = chartSalaries
                  .asMap()
                  .entries
                  .map(
                    (entry) => FlSpot(
                      entry.key.toDouble(),
                      entry.value.netSalary?.toDouble() ?? 0,
                    ),
                  )
                  .toList();
              final maxNet = spots.map((s) => s.y).fold<double>(
                    0,
                    (prev, y) => y > prev ? y : prev,
                  );
              final chartMaxY = maxNet > 0 ? maxNet * 1.15 : 1.0;
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
                            maxX: (chartSalaries.length - 1).toDouble(),
                            minY: 0,
                            maxY: chartMaxY,
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 22,
                                  interval: 1,
                                  getTitlesWidget: (value, meta) {
                                    const style = TextStyle(
                                      color: Colors.black,
                                      fontSize: 11,
                                    );
                                    final index = value.toInt();
                                    if (index < 0 || index >= chartSalaries.length) {
                                      return const SizedBox.shrink();
                                    }
                                    final label = _monthLabel(chartSalaries[index]);
                                    return Text(
                                      label,
                                      style: style,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 42,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 11,
                                      ),
                                    );
                                  },
                                ),
                              ),
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
                                spots: spots,
                                isCurved: chartSalaries.length > 2,
                                color: AppColors.sunsetOrange.withOpacity(0.8),
                                barWidth: 4,
                                dotData: const FlDotData(show: true),
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
