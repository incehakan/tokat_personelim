import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../product/constants/app_dimensions.dart';
import '../../../data/models/movable_model.dart';
import '../../../widgets/custom_error_text.dart';
import '../../../widgets/info_card_template.dart';
import '../../../widgets/loading_indicator.dart';
import '../../../widgets/text_field_with_border.dart';
import '../cubit/movable_count_cubit.dart';

class MovableCountMovablesScreen extends StatefulWidget {
  const MovableCountMovablesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MovableCountMovablesScreen> createState() => _MovableCountMovablesScreenState();
}

class _MovableCountMovablesScreenState extends State<MovableCountMovablesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taşınır Ara'),
      ),
      body: Padding(
        padding: AppDimensions.pagePadding,
        child: Column(
          children: [
            TextFieldWithBorder(
              hintText: 'Taşınır Ara',
              onChanged: (p0) {
                if (p0 != null && p0.length > 2) {
                  context.read<MovableCountCubit>().getMovables(p0);
                }
              },
            ),
            const SizedBox(height: AppDimensions.mediumGap),
            BlocBuilder<MovableCountCubit, MovableCountState>(
              builder: (context, state) {
                if (state is MovablesFailed) {
                  return Center(child: CustomErrorText(message: state.message));
                } else if (state is MovablesSuccess) {
                  return SuccessBody(movables: state.movables);
                } else if (state is MovablesInProgress) {
                  return const Center(
                    child: CustomLoadingIndicator(),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessBody extends StatelessWidget {
  const SuccessBody({Key? key, required this.movables}) : super(key: key);

  final List<MovableData> movables;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: false,
        children: List.generate(
          movables.length,
          (index) => InfoCardTemplate(
            onTap: () {
              context.read<MovableCountCubit>().selectMovable(movables[index]);
              context.pop();
            },
            title: movables[index].adi.toString(),
          ),
        ),
      ),
    );
  }
}
