import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jc_recruit_app/models/food.dart';
import 'package:jc_recruit_app/repositories/food_repository.dart';
import 'package:meta/meta.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodListLoading()) {
    on<GetFoods>(_manageGetFoodsEvent);
    on<SearchFoods>(_manageSearchFoodsEvent);
  }

  final FoodRepository foodRepository =
      FoodRepository(FirebaseFirestore.instance);

  List<FoodItem> backupFood = [];

  void _manageGetFoodsEvent(GetFoods event, Emitter<FoodState> emit) async {
    emit(FoodListLoading());

    await emit.forEach(foodRepository.getFoods(), onData: (foodList) {
      if (foodList.isEmpty) {
        return FoodListEmpty();
      }

      backupFood = foodList;
      return FoodList(foodList);
    });
  }

  void _manageSearchFoodsEvent(
      SearchFoods event, Emitter<FoodState> emit) async {
    if (state is! FoodList) {
      return;
    }

    if (event.query.isEmpty) {
      emit(FoodList(backupFood));
      return;
    }

    final foodList = (state as FoodList).foods;

    final List<FoodItem> filteredFoodList = foodList
        .where((food) => food.name.toLowerCase().contains(event.query))
        .toList();

    emit(FoodList(filteredFoodList));
  }

  // void _manageChangeFoodItemQuantityEvent(
  //     ChangeFoodItemQuantity event, Emitter<FoodState> emit) {
  //   final foodList = (state as FoodList).foods;

  //   final updatedFoodList = foodList.map((food) {
  //     if (food.id == event.foodItem.id) {
  //       return food.copyWith(quantity: event.quantity);
  //     }

  //     return food;
  //   }).toList();

  //   backupFood = foodList;

  //   emit(FoodList(updatedFoodList));
  // }
}
