import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../product/constants/app_colors.dart';
import '../../../../product/constants/app_dimensions.dart';
import '../../../../product/constants/app_strings.dart';
import '../../../../product/router/app_routes.dart';
import '../../../../product/utils/network_manager.dart';
import '../../../data/models/driver_hours_model.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/custom_error_text.dart';
import '../../../widgets/employee_information_card.dart';
import '../../../widgets/loading_indicator.dart';
import 'bloc/driver_hours_bloc.dart';

class DriverHoursScreen extends StatefulWidget {
  const DriverHoursScreen({Key? key}) : super(key: key);

  @override
  State<DriverHoursScreen> createState() => _DriverHoursScreenState();
}

class _DriverHoursScreenState extends State<DriverHoursScreen> {
  late TextEditingController _dateTimeController;
  final bloc = DriverHoursBloc(NetworkManager(Dio()));

  @override
  void initState() {
    _dateTimeController = TextEditingController(
      text: DateFormat.yMMMMd('tr').format(
        DateTime.now(),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _dateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.driverHours),
      ),
      body: BlocProvider<DriverHoursBloc>(
        create: (context) => bloc..add(GetDriverHours(DateTime.now())),
        child: Padding(
          padding: AppDimensions.pagePadding,
          child: Column(
            children: [
              const EmployeeInformationCard(),
              const SizedBox(height: AppDimensions.largeGap),
              DateSection(dateTimeController: _dateTimeController),
              const SizedBox(height: AppDimensions.largeGap),
              const DriverHoursSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class DateSection extends StatelessWidget {
  const DateSection({Key? key, required this.dateTimeController}) : super(key: key);

  final TextEditingController dateTimeController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: dateTimeController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: AppDimensions.cardRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppDimensions.cardRadius,
        ),
        suffixIcon: Icon(Ionicons.time_outline),
      ),
      onTap: () {
        showDatePicker(
          context: context,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now(),
        ).then(
          (value) {
            if (value != null) {
              dateTimeController.text = DateFormat.yMMMMd('tr').format(value);
              context.read<DriverHoursBloc>().add(GetDriverHours(value));
            }
          },
        );
      },
    );
  }
}

class DriverHoursSection extends StatelessWidget {
  const DriverHoursSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverHoursBloc, DriverHoursState>(
      builder: (context, state) {
        switch (state.status) {
          case DriverHoursStatus.initial:
          case DriverHoursStatus.loading:
            return const Center(
              child: CustomLoadingIndicator(),
            );
          case DriverHoursStatus.failure:
            return Center(
              child: CustomErrorText(message: state.statusMessage.toString()),
            );
          case DriverHoursStatus.success:
            return Expanded(
              child: ListView(
                children: List.generate(
                  state.driverHours!.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: AppDimensions.mediumGap),
                    child: DriverHoursCard(
                      hours: state.driverHours![index],
                    ),
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}

class DriverHoursCard extends StatelessWidget {
  const DriverHoursCard({Key? key, required this.hours}) : super(key: key);

  final DriverHours hours;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDimensions.pd12,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: AppDimensions.cardRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hat: ${hours.hatNo.toString()} / ${hours.hatAdi.toString()}",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
          const Divider(color: Colors.white),
          Text(
            "Sefer: ${hours.rumuz} / ${hours.seferSaat} / ${hours.plakaNo}",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
          const Divider(color: Colors.white),
          Text(
            "Karşılık 1: ${hours.karsilik1}",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: AppDimensions.mediumGap),
          Container(
            padding: AppDimensions.pd12,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: AppDimensions.buttonRadius,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Gidiş',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      'Dönüş',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                const Divider(color: AppColors.sunsetOrange),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: List.generate(
                        hours.seferSaatListe!.length,
                        (index) => Text(
                          hours.seferSaatListe![index].gidisSaat.toString(),
                        ),
                      ),
                    ),
                    Column(
                      children: List.generate(
                        hours.seferSaatListe!.length,
                        (index) => Text(
                          hours.seferSaatListe![index].donusSaat.toString(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.mediumGap),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: WhiteAppButton(
                  text: 'Araç Konumu',
                  onPressed: () {
                    context.pushNamed(
                      AppRoutes.busLocation,
                      extra: hours.plakaNo.toString(),
                    );
                  },
                ),
              ),
              const SizedBox(width: AppDimensions.smallGap),
              Expanded(
                child: WhiteAppButton(
                  text: 'Güzergah Bilgisi',
                  onPressed: () {
                    context.pushNamed(
                      AppRoutes.busRoute,
                      extra: hours.hatNo.toString(),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// Mock Data
// return Expanded(
//             child: ListView(
//               children: List.generate(
//                 2,
//                 (index) => Padding(
//                   padding: const EdgeInsets.only(bottom: AppDimensions.mediumGap),
//                   child: DriverHoursCard(
//                     hours: DriverHours(
//                       aracId: 123.0,
//                       hatAdi: 'Çeşme',
//                       hatNo: 'KL08',
//                       rumuz: 'Rumuz',
//                       seferSaat: '22.00',
//                       plakaNo: '07T4107',
//                       seferSaatListe: [
//                         Hours(
//                           gidisSaat: '12.00',
//                           donusSaat: '13.00',
//                         ),
//                         Hours(
//                           gidisSaat: '13.00',
//                           donusSaat: '14.00',
//                         ),
//                         Hours(
//                           gidisSaat: '14.00',
//                           donusSaat: '15.00',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );