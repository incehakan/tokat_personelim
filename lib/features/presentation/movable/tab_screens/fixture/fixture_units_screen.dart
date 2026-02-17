import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'cubit/fixture_cubit.dart';
import '../../../../widgets/info_card_template.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../../../product/constants/app_dimensions.dart';

import '../../../../data/models/fixture_unit_model.dart';
import '../../../../widgets/custom_error_text.dart';

class FixtureUnitsScreen extends StatefulWidget {
  const FixtureUnitsScreen({Key? key}) : super(key: key);

  @override
  State<FixtureUnitsScreen> createState() => _FixtureUnitsScreenState();
}

class _FixtureUnitsScreenState extends State<FixtureUnitsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FixtureCubit>().getUnits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Birim Seçiniz'),
      ),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: BlocBuilder<FixtureCubit, FixtureState>(
          builder: (context, state) {
            if (state is UnitsFailed) {
              return CustomErrorText(message: state.message);
            } else if (state is UnitsSuccess) {
              return SuccessBody(units: state.units);
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

class SuccessBody extends StatelessWidget {
  const SuccessBody({Key? key, required this.units}) : super(key: key);

  final List<FixtureUnit> units;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
        units.length,
        (index) => InfoCardTemplate(
          onTap: () {
            context.read<FixtureCubit>().selectUnit(units[index]);
            context.pop();
          },
          title: units[index].adi.toString(),
        ),
      ),
    );
  }
}
