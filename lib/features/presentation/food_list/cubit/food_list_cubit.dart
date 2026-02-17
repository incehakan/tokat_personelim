import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/models/food_model.dart';
import '../../../data/repository/corporate_repository.dart';

part 'food_list_state.dart';

class FoodListCubit extends Cubit<FoodListState> {
  FoodListCubit(this.corporateRepository) : super(FoodListInitial());

  final CorporateRepository corporateRepository;

  Future<void> getFoodList(String type) async {
    final month = DateTime.now().month;
    emit(FoodListInProgress());
    final response = await corporateRepository.fetchFoodList(
      month.toString(),
      type,
    );

    response.fold(
      (l) => emit(FoodListFailed(l.message)),
      (r) => emit(FoodListSuccess(r)),
    );
  }
}
