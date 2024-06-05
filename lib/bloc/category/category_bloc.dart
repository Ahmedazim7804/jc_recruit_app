import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:jc_recruit_app/models/category.dart';
import 'package:jc_recruit_app/repositories/categories_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryLoading()) {
    on<GetCategories>(_handleGetCategories);
  }

  final CategoryRepository _categoryRepository = CategoryRepository(
    FirebaseFirestore.instance,
  );

  void _handleGetCategories(
      GetCategories event, Emitter<CategoryState> emit) async {
    await emit.forEach(
      _categoryRepository.getCategories(),
      onData: (data) {
        if (data.isEmpty) {
          return CategoryListEmpty();
        }
        return CategoriesLoaded(data);
      },
    );
  }
}
