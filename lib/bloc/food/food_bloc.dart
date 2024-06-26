import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jc_recruit_app/models/category.dart';
import 'package:jc_recruit_app/models/food.dart';
import 'package:jc_recruit_app/repositories/food_repository.dart';
import 'package:jc_recruit_app/utils/enum.dart';
import 'package:meta/meta.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodListLoading()) {
    on<GetFoods>(_manageGetFoodsEvent);
    on<SearchFoods>(_manageSearchFoodsEvent);
    on<FilterFoods>(_manageFilterFoodsEvent);
    on<ResetFilters>(_manageResetFilterFoodsEvent);
    on<SortFoods>(_manageSortFoodsEvent);
  }

  final FoodRepository foodRepository =
      FoodRepository(FirebaseFirestore.instance);

  List<FoodItem> backupFood = [];
  String _searchQuery = "";
  List<String> _selectedCategoriesId = [];
  Sort? sort;

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
        .where((food) => _selectedCategoriesId.contains(food.categoryId))
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

    _selectedCategoriesId = event.categories.map((e) => e.id).toList();

    filterAndEmit(emitter);
  }

  void _manageSortFoodsEvent(SortFoods event, Emitter<FoodState> emit) {
    if (state.runtimeType != FoodList) {
      return;
    }

    if (sort == null || sort == Sort.DESCENDING) {
      sort = Sort.ASCENDING;
    } else {
      sort = Sort.DESCENDING;
    }

    List<FoodItem> sortedFoods = (state as FoodList).foods;

    switch (event.sortBy) {
      case SortBy.NAME:
        sortedFoods.sort(
          (a, b) {
            if (sort == Sort.ASCENDING) {
              return a.name.toLowerCase().compareTo(b.name.toLowerCase());
            }

            return b.name.toLowerCase().compareTo(a.name.toLowerCase());
          },
        );
        break;
      case SortBy.PRICE:
        sortedFoods.sort((a, b) {
          if (sort == Sort.ASCENDING) {
            return a.price.compareTo(b.price);
          }

          return b.price.compareTo(a.price);
        });
      default:
    }

    emit(FoodList(sortedFoods));
  }

  void _manageResetFilterFoodsEvent(
      ResetFilters event, Emitter<FoodState> emit) {
    emit(FoodList(backupFood));
  }
}
