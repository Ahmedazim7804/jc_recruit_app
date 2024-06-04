part of 'food_bloc.dart';

@immutable
sealed class FoodEvent {}

final class GetFoods extends FoodEvent {}

final class SearchFoods extends FoodEvent {
  SearchFoods(this.query);

  final String query;
}
