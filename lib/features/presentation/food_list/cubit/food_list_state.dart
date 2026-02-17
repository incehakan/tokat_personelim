part of 'food_list_cubit.dart';

@immutable
class FoodListState {}

class FoodListInitial extends FoodListState {}

class FoodListInProgress extends FoodListState {}

class FoodListSuccess extends FoodListState {
  final List<FoodData> foods;

  FoodListSuccess(this.foods);
}

class FoodListFailed extends FoodListState {
  final String message;

  FoodListFailed(this.message);
}
