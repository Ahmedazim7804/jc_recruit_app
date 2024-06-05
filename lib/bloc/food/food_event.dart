part of 'food_bloc.dart';

@immutable
sealed class FoodEvent {}

final class GetFoods extends FoodEvent {}

final class SearchFoods extends FoodEvent {
  SearchFoods(this.query);

  final String query;
}

final class FilterFoods extends FoodEvent {
  FilterFoods(this.categories);

  final List<CategoryItem> categories;
}

final class ResetFilters extends FoodEvent {}
