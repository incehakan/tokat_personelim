import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/models/leave.dart';
import '../../../../../data/models/subordinates_model.dart';
import 'cubit/subordinate_leave_info_cubit.dart';
import '../../../../../widgets/loading_indicator.dart';
import '../../../../../../product/extensions/context_extensions.dart';
import '../../../../../../product/utils/dependency_injection.dart';

import '../../../../../../product/constants/app_dimensions.dart';
import '../../../../../../product/constants/app_strings.dart';
import '../../../../../widgets/custom_error_text.dart';
import '../../../../../widgets/info_card_template.dart';
import '../../../../../widgets/info_screen_header.dart';
import '../../../../../widgets/red_container.dart';

class SubordinateLeaveInfoScreen extends StatefulWidget {
  const SubordinateLeaveInfoScreen({Key? key, required this.subordinate}) : super(key: key);

  final Subordinate subordinate;

  @override
  State<SubordinateLeaveInfoScreen> createState() => _SubordinateLeaveInfoScreenState();
}

class _SubordinateLeaveInfoScreenState extends State<SubordinateLeaveInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<SubordinateLeaveInfoCubit>()
        ..getSubordinateLeaveInfo(
          widget.subordinate.sicilId!.round().toString(),
        ),
      child: BlocBuilder<SubordinateLeaveInfoCubit, SubordinateLeaveInfoState>(
        builder: (context, state) {
          if (state is SubordinateLeaveInfoFailed) {
            // return SuccessBody(
            //   leaveData: LeaveData(
            //     remainAnnualLeave: 25,
            //     usedAnnualLeave: 30,
            //     leaves: [
            //       Leave(
            //         employeeId: 123,
            //         type: 'Tip',
            //         startingDate: '26.12.1996',
            //         endDate: '28.12.1996',
            //         dayOffCount: 3,
            //       )
            //     ],
            //   ),
            // );
            return Center(
              child: CustomErrorText(message: state.message),
            );
          } else if (state is SubordinateLeaveInfoSuccess) {
            return SuccessBody(
              leaveInfo: state.leaveData,
            );
          } else {
            return const Center(
              child: CustomLoadingIndicator(),
            );
          }
        },
      ),
    );
  }
}
// Mock Data

class SuccessBody extends StatelessWidget {
  const SuccessBody({Key? key, required this.leaveInfo}) : super(key: key);

  final LeaveInfo leaveInfo;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppDimensions.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RedContainer(
                  title: AppStrings.usedAnnualLeave,
                  info: leaveInfo.usedAnnualLeave!.toInt().toString(),
                ),
                RedContainer(
                  title: AppStrings.remainAnnualLeave,
                  info: leaveInfo.remainAnnualLeave!.toInt().toString(),
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
                  leaveInfo.leaves!.length,
                  (index) => LeaveInformationCard(
                    leave: leaveInfo.leaves![index],
                  ),
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
    required this.leaveInfo,
  }) : super(key: key);

  final LeaveInfo leaveInfo;

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
              value: leaveInfo.usedAnnualLeave!.toDouble(),
              color: Colors.red,
              title: '${leaveInfo.usedAnnualLeave!.toInt()} Gün',
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            PieChartSectionData(
              radius: 60,
              value: leaveInfo.remainAnnualLeave!.toDouble(),
              color: Colors.green,
              title: '${leaveInfo.remainAnnualLeave!.toInt()} Gün',
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
