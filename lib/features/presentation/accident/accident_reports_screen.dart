import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/utils/dependency_injection.dart';
import '../../data/models/accident_report_model.dart';
import '../../widgets/custom_error_text.dart';
import '../../widgets/loading_indicator.dart';
import 'cubit/accident_cubit.dart';

class AccidentReportsScreen extends StatefulWidget {
  const AccidentReportsScreen({Key? key}) : super(key: key);

  @override
  State<AccidentReportsScreen> createState() => _AccidentReportsScreenState();
}

class _AccidentReportsScreenState extends State<AccidentReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<AccidentCubit>()..getAccidentReports(),
      child: BlocBuilder<AccidentCubit, AccidentState>(
        builder: (context, state) {
          if (state is AccidentReportsFailed) {
            return Center(
              child: CustomErrorText(message: state.message),
            );
          } else if (state is AccidentReportsSuccess) {
            return SuccessScreen(reports: state.reports);
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

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key, required this.reports}) : super(key: key);

  final List<AccidentReport> reports;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: reports.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: ExpansionTile(
              textColor: Colors.red,
              title: Text(
                "${index + 1}) ${reports[index].olayYeri}",
              ),
              subtitle: Text(
                "Tarih: ${reports[index].olayTarihi!.day.toString().padLeft(2, "0")}/${reports[index].olayTarihi!.month.toString().padLeft(2, "0")}/${reports[index].olayTarihi!.year} - ${reports[index].olayTarihi!.hour.toString().padLeft(2, "0")}:${reports[index].olayTarihi!.minute.toString().padLeft(2, "0")}",
              ),
              children: <Widget>[
                ListTile(
                  title: Text(
                    reports[index].aciklama.toString(),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
