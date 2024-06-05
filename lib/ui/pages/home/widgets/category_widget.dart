import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jc_recruit_app/bloc/category/category_bloc.dart';
import 'package:jc_recruit_app/repositories/categories_repository.dart';
import 'package:jc_recruit_app/ui/pages/home/widgets/category_item.dart';
import 'package:jc_recruit_app/ui/pages/home/widgets/category_widget_shimmer.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Categories",
              style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoriesLoaded) {
              return Wrap(
                spacing: 12,
                children: state.categories.map((category) {
                  return FoodCategoryItemWidget(
                    categoryItem: category,
                  );
                }).toList(),
              );
            }

            return const CategoryWidgetShimmer();
          },
        )
      ],
    );
  }
}
