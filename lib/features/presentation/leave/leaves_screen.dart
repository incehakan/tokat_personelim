import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/leaves_bloc.dart';
import '../../../product/utils/network_manager.dart';
import '../../widgets/custom_error_text.dart';

import '../../../product/constants/app_dimensions.dart';
import '../../../product/constants/app_strings.dart';
import '../../../product/extensions/context_extensions.dart';
import '../../data/models/leave.dart';
import '../../widgets/employee_information_card.dart';
import '../../widgets/info_card_template.dart';
import '../../widgets/info_screen_header.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/red_container.dart';

class LeaveInformationScreen extends StatefulWidget {
  const LeaveInformationScreen({Key? key}) : super(key: key);

  @override
  State<LeaveInformationScreen> createState() => _LeaveInformationScreenState();
}

class _LeaveInformationScreenState extends State<LeaveInformationScreen> {
  final bloc = LeavesBloc(NetworkManager(Dio()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.leaveInfo),
      ),
      body: BlocProvider(
        create: (context) => bloc..add(GetLeaves()),
        child: BlocBuilder<LeavesBloc, LeavesState>(
          builder: (context, state) {
            switch (state.status) {
              case LeaveStatus.initial:
              case LeaveStatus.loading:
                return const Center(
                  child: CustomLoadingIndicator(),
                );
              case LeaveStatus.failure:
                return CustomErrorText(message: state.statusMessage);
              case LeaveStatus.success:
                return LeaveSuccessBody(
                  leaveInfo: state.leaveInfo,
                );
            }
          },
        ),
      ),
    );
  }
}

class LeaveSuccessBody extends StatelessWidget {
  const LeaveSuccessBody({Key? key, this.leaveInfo}) : super(key: key);

  final LeaveInfo? leaveInfo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppDimensions.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const EmployeeInformationCard(),
            const SizedBox(height: AppDimensions.mediumGap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RedContainer(
                  title: AppStrings.usedAnnualLeave,
                  info: leaveInfo?.usedAnnualLeave?.floor().toString(),
                ),
                RedContainer(
                  title: AppStrings.remainAnnualLeave,
                  info: leaveInfo?.remainAnnualLeave?.floor().toString(),
                )
              ],
            ),
            const SizedBox(height: AppDimensions.mediumGap),
            ChartSection(leaveInfo: leaveInfo),
            const SizedBox(height: AppDimensions.mediumGap),
            const ChartInfoSection(),
            const SizedBox(height: AppDimensions.largeGap),
            const InfoScreenHeader(text: AppStrings.leaveDetailInfo),
            Padding(
              padding: AppDimensions.pd8,
              child: Column(
                children: List.generate(
                  leaveInfo!.leaves!.length,
                  (index) => LeaveInformationCard(leave: leaveInfo!.leaves![index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartSection extends StatelessWidget {
  const ChartSection({
    Key? key,
    this.leaveInfo,
  }) : super(key: key);

  final LeaveInfo? leaveInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.2,
      child: PieChart(
        PieChartData(
          sectionsSpace: 8,
          centerSpaceRadius: 15,
          sections: <PieChartSectionData>[
            PieChartSectionData(
              radius: 60,
              value: leaveInfo?.usedAnnualLeave!.toDouble(),
              color: Colors.red,
              title: '${leaveInfo?.usedAnnualLeave!.toInt()} Gün',
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            PieChartSectionData(
              radius: 60,
              value: leaveInfo?.remainAnnualLeave!.toDouble(),
              color: Colors.green,
              title: '${leaveInfo?.remainAnnualLeave!.toInt()} Gün',
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChartInfoSection extends StatelessWidget {
  const ChartInfoSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InfoIndicator(text: AppStrings.remainAnnualLeave, color: Colors.green),
        InfoIndicator(
          text: AppStrings.usedAnnualLeave,
          color: Colors.red,
        )
      ],
    );
  }
}

class InfoIndicator extends StatelessWidget {
  const InfoIndicator({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}

class LeaveInformationCard extends StatelessWidget {
  const LeaveInformationCard({Key? key, required this.leave}) : super(key: key);

  final Leave leave;

  @override
  Widget build(BuildContext context) {
    return InfoCardTemplate(
      title: leave.type.toString(),
      subtitle: '${leave.startingDate} - ${leave.endDate}',
      trailing: Container(
        padding: AppDimensions.pd8,
        decoration: BoxDecoration(
          borderRadius: AppDimensions.buttonRadius,
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: [
            Text(
              leave.dayOffCount.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
            Text(
              'Gün',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
