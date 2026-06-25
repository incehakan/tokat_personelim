import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../product/constants/app_dimensions.dart';
import '../../../product/constants/app_strings.dart';
import '../../../product/constants/endpoints.dart';
import '../../../product/router/app_routes.dart';
import '../../../product/utils/network_manager.dart';
import '../../data/models/salary.dart';
import '../../widgets/custom_error_text.dart';
import '../../widgets/employee_information_card.dart';
import '../../widgets/info_card_template.dart';
import '../../widgets/info_screen_header.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/red_container.dart';
import 'bloc/salary_bloc.dart';

/// Maaş Bilgilerim
class SalaryScreen extends StatefulWidget {
  const SalaryScreen({Key? key}) : super(key: key);

  @override
  State<SalaryScreen> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {
  final bloc = SalaryBloc(NetworkManager(Dio()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.salaryInfo),
      ),
      body: BlocProvider(
        create: (context) => bloc..add(GetSalary()),
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
                final latestSalary = state.salaries?.isNotEmpty == true
                    ? state.salaries!.first
                    : null;
                return SalarySuccessBody(
                  salaries: state.salaries,
                  grossSalary: latestSalary?.formattedGrossSalary,
                  netSalary: latestSalary?.formattedNetSalary,
                  salaryCuts: latestSalary?.formattedSalaryCuts,
                );
            }
          },
        ),
      ),
    );
  }
}

class SalarySuccessBody extends StatelessWidget {
  const SalarySuccessBody({
    Key? key,
    required this.salaries,
    this.grossSalary,
    this.netSalary,
    this.salaryCuts,
  }) : super(key: key);

  final List<Salary>? salaries;
  final String? grossSalary;
  final String? netSalary;
  final String? salaryCuts;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: AppDimensions.pagePadding,
        child: Column(
          children: [
            const EmployeeInformationCard(),
            const SizedBox(height: AppDimensions.mediumGap),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RedContainer(
                  title: AppStrings.grossSalary,
                  info: '${grossSalary ?? '-'} TL',
                ),
                RedContainer(
                  title: AppStrings.netSalary,
                  info: '${netSalary ?? '-'} TL',
                ),
                RedContainer(
                  title: AppStrings.salaryCuts,
                  info: '${salaryCuts ?? '-'} TL',
                ),
              ],
            ),
            const InfoScreenHeader(text: AppStrings.salaryDetailInfo),
            salaries != null
                ? Padding(
                    padding: AppDimensions.pd8,
                    child: Column(
                      children: List.generate(
                        salaries!.length,
                        (index) => SalaryCard(
                          salary: salaries![index],
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class SalaryCard extends StatelessWidget {
  const SalaryCard({
    Key? key,
    required this.salary,
  }) : super(key: key);

  final Salary salary;

  @override
  Widget build(BuildContext context) {
    return InfoCardTemplate(
      title: '${salary.month.toString()} - ${salary.payrollYear} / ${salary.payrollType}',
      subtitle: '${AppStrings.amount} : ${salary.formattedNetSalary ?? '-'} TL',
      trailing: Container(
        padding: AppDimensions.pd16,
        decoration: BoxDecoration(
          borderRadius: AppDimensions.buttonRadius,
          color: Theme.of(context).primaryColor,
        ),
        child: const Icon(
          Icons.find_in_page,
          color: Colors.white,
        ),
      ),
      onTap: () {
        final payrollUrl = '${Endpoints.baseUrl}${Endpoints.payroll}/${salary.payrollYear}/${salary.payrollMonth}/${salary.payrollCode}';
        context.pushNamed(
          AppRoutes.payroll,
          extra: payrollUrl,
        );
      },
    );
  }
}
