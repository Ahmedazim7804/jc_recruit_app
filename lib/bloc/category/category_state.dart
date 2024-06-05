part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryLoading extends CategoryState {}

final class CategoryListEmpty extends CategoryState {}

final class CategoriesLoaded extends CategoryState {
  final List<CategoryItem> categories;
  final List<CategoryItem>? selectedCategories;

  const CategoriesLoaded({required this.categories, this.selectedCategories});

  CategoriesLoaded copyWith({
    List<CategoryItem>? categories,
    List<CategoryItem>? selectedCategories,
  }) {
    return CategoriesLoaded(
        categories: categories ?? [],
        selectedCategories: selectedCategories ?? []);
  }

  @override
  List<Object> get props => [categories];
}
