import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import '../../../product/constants/app_dimensions.dart';
import '../../../product/constants/app_strings.dart';
import '../../../product/utils/dependency_injection.dart';
import '../../data/models/food_model.dart';
import '../../widgets/custom_error_text.dart';
import '../../widgets/info_card_template.dart';
import '../../widgets/loading_indicator.dart';
import 'cubit/food_list_cubit.dart';

class FoodListScreen extends StatefulWidget {
  const FoodListScreen({Key? key}) : super(key: key);

  @override
  State<FoodListScreen> createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.foodList),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Aylık Normal Menü',
              ),
              Tab(
                text: 'Aylık Diyet Menü',
              ),
            ],
          ),
        ),
        body: const Padding(
          padding: AppDimensions.pagePadding,
          child: TabBarView(
            children: [
              NormalMenuView(),
              DietMenuView(),
            ],
          ),
        ),
      ),
    );
  }
}

class NormalMenuView extends StatelessWidget {
  const NormalMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<FoodListCubit>()..getFoodList(1.toString()),
      child: BlocBuilder<FoodListCubit, FoodListState>(
        builder: (context, state) {
          if (state is FoodListFailed) {
            return Center(
              child: CustomErrorText(message: state.message),
            );
          } else if (state is FoodListSuccess) {
            return Column(
              children: [
                FoodCard(foodData: state.foods.first.details!.first),
              ],
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

class DietMenuView extends StatelessWidget {
  const DietMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<FoodListCubit>()..getFoodList(2.toString()),
      child: BlocBuilder<FoodListCubit, FoodListState>(
        builder: (context, state) {
          if (state is FoodListFailed) {
            return Center(
              child: CustomErrorText(message: state.message),
            );
          } else if (state is FoodListSuccess) {
            return Column(
              children: [
                FoodCard(foodData: state.foods.first.details!.first),
              ],
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

class FoodCard extends StatelessWidget {
  const FoodCard({Key? key, required this.foodData}) : super(key: key);

  final FoodDataDetail foodData;

  @override
  Widget build(BuildContext context) {
    return InfoCardTemplate(
      leading: const Icon(Ionicons.fast_food),
      title: foodData.yemekler!.first.yemek.toString(),
      subtitle: DateFormat.yMMMd('tr').format(foodData.tarih!).toString(),
      trailing: const SizedBox(),
    );
  }
}
