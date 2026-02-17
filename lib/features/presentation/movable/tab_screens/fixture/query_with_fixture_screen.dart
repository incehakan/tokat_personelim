import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../product/constants/app_dimensions.dart';
import '../../../../../product/router/app_routes.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/custom_error_text.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../../widgets/text_field_with_border.dart';
import '../../fixture_card.dart';
import 'cubit/fixture_cubit.dart';

class QueryWithFixtureScreen extends StatefulWidget {
  const QueryWithFixtureScreen({Key? key}) : super(key: key);

  @override
  State<QueryWithFixtureScreen> createState() => _QueryWithFixtureScreenState();
}

class _QueryWithFixtureScreenState extends State<QueryWithFixtureScreen> {
  late TextEditingController _unitController;
  late TextEditingController _fixtureNoController;

  @override
  void initState() {
    _unitController = TextEditingController();
    _fixtureNoController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _unitController.dispose();
    _fixtureNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SelectUnitSection(controller: _unitController),
          const SizedBox(height: AppDimensions.mediumGap),
          FixtureNoSection(controller: _fixtureNoController),
          const SizedBox(height: AppDimensions.mediumGap),
          AppButton(
            text: 'Sorgula',
            onPressed: () {
              if (context.read<FixtureCubit>().unit != null && _fixtureNoController.text.isNotEmpty) {
                context.read<FixtureCubit>().queryWithFixture(
                      context.read<FixtureCubit>().unit!.id.toString(),
                      _fixtureNoController.text,
                    );
              }
            },
          ),
          const SizedBox(height: AppDimensions.mediumGap),
          BlocBuilder<FixtureCubit, FixtureState>(
            builder: (context, state) {
              if (state is QueryWithFixtureInProgress) {
                return const Center(
                  child: CustomLoadingIndicator(),
                );
              } else if (state is QueryWithFixtureFailed) {
                return CustomErrorText(message: state.message);
              } else if (state is QueryWithFixtureSuccess) {
                return FixtureCard(fixture: state.fixture);
              } else {
                return const Center(
                  child: Text('Taşınır bilgisi görüntülemek sorgulama yapınız.'),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class SelectUnitSection extends StatelessWidget {
  const SelectUnitSection({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFieldWithBorder(
      controller: controller,
      hintText: 'Birim Seçiniz',
      readOnly: true,
      onTap: () {
        context.pushNamed(AppRoutes.fixtureUnits).whenComplete(() {
          if (context.read<FixtureCubit>().unit != null) {
            controller.text = context.read<FixtureCubit>().unit!.adi.toString();
          }
        });
      },
    );
  }
}

class FixtureNoSection extends StatelessWidget {
  const FixtureNoSection({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFieldWithBorder(
      controller: controller,
      hintText: 'Demirbaş No',
    );
  }
}
