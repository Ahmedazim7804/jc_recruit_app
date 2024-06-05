import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jc_recruit_app/models/category.dart';
import 'package:jc_recruit_app/models/food.dart';
import 'package:jc_recruit_app/repositories/food_repository.dart';
import 'package:meta/meta.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodListLoading()) {
    on<GetFoods>(_manageGetFoodsEvent);
    on<SearchFoods>(_manageSearchFoodsEvent);
    on<FilterFoods>(_manageFilterFoodsEvent);
    on<ResetFilters>(_manageResetFilterFoodsEvent);
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

  void _manageFilterFoodsEvent(FilterFoods event, Emitter<FoodState> emit) {
    if (state is FoodListEmpty) {
      return;
    }

    if (state is FoodListLoading) {
      return;
    }

    List<String> categoriesIds =
        event.categories.map((e) => e.name.toLowerCase()).toList();

    emit(FoodList(backupFood
        .where((food) => categoriesIds.contains(food.category.value))
        .toList()));
  }

  void _manageResetFilterFoodsEvent(
      ResetFilters event, Emitter<FoodState> emit) {
    emit(FoodList(backupFood));
  }
}
