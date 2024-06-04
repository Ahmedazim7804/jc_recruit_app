part of 'food_bloc.dart';

@immutable
sealed class FoodState {}

final class FoodListEmpty extends FoodState {}

final class FoodListLoading extends FoodState {}

final class FoodList extends FoodState {
  FoodList(this.foods);

  final List<FoodItem> foods;
}
