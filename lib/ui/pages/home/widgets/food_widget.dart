import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jc_recruit_app/bloc/category/category_bloc.dart';
import 'package:jc_recruit_app/bloc/food/food_bloc.dart';
import 'package:jc_recruit_app/models/food.dart';
import 'package:jc_recruit_app/ui/pages/home/widgets/food_tile.dart';
import 'package:jc_recruit_app/ui/pages/home/widgets/food_widget_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class FoodListWidget extends StatelessWidget {
  const FoodListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Food",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.87),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.sort,
                  color: Colors.white.withOpacity(0.87),
                ),
              ),
            ],
          ),
          Expanded(
            child: BlocListener<CategoryBloc, CategoryState>(
              listener: (context, state) {
                if (state is CategoriesLoaded) {
                  if (state.selectedCategories != null &&
                      state.selectedCategories!.isNotEmpty) {
                    context
                        .read<FoodBloc>()
                        .add(FilterFoods(state.selectedCategories!));
                  } else {
                    context.read<FoodBloc>().add(ResetFilters());
                  }
                }
              },
              child: BlocBuilder<FoodBloc, FoodState>(
                builder: (context, state) {
                  if (state is FoodListEmpty) {
                    return Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Image.asset(
                          'assets/not_found.png',
                          height: 80,
                          width: 80,
                          color: Colors.white.withOpacity(0.75),
                        ),
                        Text(
                          "No food available",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                          ),
                        ),
                      ],
                    );
                  }

                  if (state is FoodList) {
                    final List<FoodItem> foodItems = state.foods;

                    return ListView.separated(
                      itemCount: state.foods.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) =>
                          FoodItemTile(foodItem: foodItems[index]),
                    );
                  }

                  return const FoodTileShimmer();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
