import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/corporate_salary_bloc.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/info_card_template.dart';
import '../../widgets/loading_indicator.dart';
import '../../../product/constants/app_dimensions.dart';
import '../../../product/constants/app_strings.dart';
import '../../../product/router/app_routes.dart';

class CorporateSalaryScreen extends StatefulWidget {
  const CorporateSalaryScreen({Key? key}) : super(key: key);

  @override
  State<CorporateSalaryScreen> createState() => _CorporateSalaryScreenState();
}

class _CorporateSalaryScreenState extends State<CorporateSalaryScreen> {
  @override
  void initState() {
    context.read<CorporateSalaryBloc>().add(CorporateSalaryInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.salaryInfo),
      ),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: BlocBuilder<CorporateSalaryBloc, CorporateSalaryState>(
          builder: (context, state) {
            switch (state.dateStatus) {
              case CorporateDateStatus.loading:
                return const CustomLoadingIndicator();
              case CorporateDateStatus.success:
                return Column(
                  children: [
                    CustomDropdown(
                      initialSelection: DateTime.now().year,
                      length: context.read<CorporateSalaryBloc>().state.years!.length,
                      values: context.read<CorporateSalaryBloc>().state.years!,
                      onSelected: (int year) => context.read<CorporateSalaryBloc>().add(SelectYear(year)),
                    ),
                    const SizedBox(height: AppDimensions.mediumGap),
                    Expanded(
                      child: ListView.builder(
                        itemCount: context.read<CorporateSalaryBloc>().state.months!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InfoCardTemplate(
                            title: "${index + 1}. Ay Maaş Detayları",
                            onTap: () {
                              context.read<CorporateSalaryBloc>().add(SelectMonth(index + 1));
                              context.pushNamed(AppRoutes.corporatePayroll);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
