import 'package:flutter/material.dart';
import 'package:jc_recruit_app/widgets/category_food_item.dart';

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
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white.withOpacity(0.87),
              ),
            ),
          ],
        ),
        const Wrap(
          spacing: 12,
          children: [
            FoodCategoryItemWidget(
              image: 'assets/foods/dairy.png',
              name: 'Dairy',
            ),
            FoodCategoryItemWidget(
              image: 'assets/foods/drinks.png',
              name: 'Drinks',
            ),
            FoodCategoryItemWidget(
              image: 'assets/foods/food.png',
              name: 'Food',
            ),
            FoodCategoryItemWidget(
              image: 'assets/foods/munchies.png',
              name: "Munchies",
            ),
          ],
        )
      ],
    );
  }
}
