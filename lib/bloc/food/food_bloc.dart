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
  String _searchQuery = "";
  List<String> _selectedCategoriesId = [];

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

  void filterAndEmit(Emitter<FoodState> emit) {
    final Set<FoodItem> filteredBySearch = _filterBySearch();
    final Set<FoodItem> filteredByCategories = _filterByCategories();

    final List<FoodItem> filteredFoods =
        filteredBySearch.intersection(filteredByCategories).toList();

    emit(FoodList(filteredFoods));
  }

  Set<FoodItem> _filterBySearch() {
    if (_searchQuery.isEmpty) {
      return backupFood.toSet();
    }

    return backupFood
        .where((food) => food.name.toLowerCase().contains(_searchQuery))
        .toSet();
  }

  Set<FoodItem> _filterByCategories() {
    if (_selectedCategoriesId.isEmpty) {
      return backupFood.toSet();
    }

    return backupFood
        .where((food) => _selectedCategoriesId.contains(food.category.value))
        .toSet();
  }

  void _manageSearchFoodsEvent(
      SearchFoods event, Emitter<FoodState> emitter) async {
    if (state is! FoodList) {
      return;
    }

    _searchQuery = event.query;

    filterAndEmit(emitter);
  }

  void _manageFilterFoodsEvent(FilterFoods event, Emitter<FoodState> emitter) {
    if (state is FoodListEmpty) {
      return;
    }

    if (state is FoodListLoading) {
      return;
    }

    _selectedCategoriesId =
        event.categories.map((e) => e.name.toLowerCase()).toList();

    filterAndEmit(emitter);
  }

  void _manageResetFilterFoodsEvent(
      ResetFilters event, Emitter<FoodState> emit) {
    emit(FoodList(backupFood));
  }
}
