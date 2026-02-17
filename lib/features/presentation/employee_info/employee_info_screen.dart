import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../product/constants/app_dimensions.dart';
import '../../../product/constants/app_images.dart';
import '../../../product/constants/app_strings.dart';
import '../../../product/enums/subordinate_type.dart';
import '../../../product/extensions/context_extensions.dart';
import '../../../product/extensions/subordinate_type_extension.dart';
import '../../../product/router/app_routes.dart';
import '../../../product/utils/dependency_injection.dart';
import '../../data/models/subordinates_model.dart';
import '../../widgets/custom_error_text.dart';
import '../../widgets/info_card_template.dart';
import '../../widgets/info_screen_header.dart';
import '../../widgets/loading_indicator.dart';
import 'cubit/subordinates_cubit.dart';

class EmployeeInfoScreen extends StatefulWidget {
  const EmployeeInfoScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeInfoScreen> createState() => _EmployeeInfoScreenState();
}

class _EmployeeInfoScreenState extends State<EmployeeInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.employeeInfo),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => List.generate(
              SubordinateType.values.length,
              (index) => PopupMenuItem(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: AppDimensions.circularRadius,
                      child: CircleAvatar(
                        backgroundColor: SubordinateType.values[index].color,
                        maxRadius: 10,
                        minRadius: 10,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(SubordinateType.values[index].title)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => getIt.get<SubordinatesCubit>()..getSubordinates(),
        child: BlocBuilder<SubordinatesCubit, SubordinatesState>(
          builder: (context, state) {
            if (state is SubordinatesFailed) {
              // return EmployeeInfoScreenSuccessBody(
              //   subordinates: [
              //     Subordinate(
              //       sicilId: 18349.0,
              //       adiSoyadi: 'Feyzullah Kodat',
              //       tip: 2.0,
              //     ),
              //   ],
              // );
              return Center(
                child: CustomErrorText(message: state.message),
              );
            } else if (state is SubordinatesSuccess) {
              return EmployeeInfoScreenSuccessBody(subordinates: state.subordinates);
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

class EmployeeInfoScreenSuccessBody extends StatelessWidget {
  const EmployeeInfoScreenSuccessBody({Key? key, required this.subordinates}) : super(key: key);

  final List<Subordinate> subordinates;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppDimensions.pagePadding,
      child: Column(
        children: [
          const InfoScreenHeader(
            text: "Size bağlı bulunan personellerin bilgileri:",
          ),
          Expanded(
            child: ListView(
              children: List.generate(
                subordinates.length,
                (index) => SubordinateCard(
                  subordinate: subordinates[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SubordinateCard extends StatelessWidget {
  const SubordinateCard({Key? key, required this.subordinate}) : super(key: key);

  final Subordinate subordinate;

  @override
  Widget build(BuildContext context) {
    return InfoCardTemplate(
      onTap: () => context.pushNamed(
        AppRoutes.employeeInfoDetail,
        extra: subordinate,
      ),
      title: subordinate.adiSoyadi.toString(),
      leading: subordinate.fotograf != null
          ? Container(
              width: context.width / 9,
              height: context.width / 9,
              decoration: BoxDecoration(
                border: Border.all(
                  color: SubordinateType.values[subordinate.tip!.round()].color,
                  width: 2,
                ),
                image: DecorationImage(
                  image: MemoryImage(
                    base64Decode(
                      subordinate.fotograf!,
                    ),
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(80),
                color: SubordinateType.values[subordinate.tip!.round()].color,
              ),
            )
          : Container(
              width: context.width / 9,
              height: context.width / 9,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(
                    AppImages.userNotFoundImage,
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(80),
                border: Border.all(
                  color: SubordinateType.values[subordinate.tip!.round()].color,
                  width: 2,
                ),
              ),
            ),
    );
  }
}
