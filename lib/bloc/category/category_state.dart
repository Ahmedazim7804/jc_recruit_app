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

  const CategoriesLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}
