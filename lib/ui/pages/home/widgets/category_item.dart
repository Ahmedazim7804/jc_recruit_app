import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jc_recruit_app/bloc/category/category_bloc.dart';
import 'package:jc_recruit_app/models/category.dart';
import 'package:jc_recruit_app/ui/common_widgets/network_image_shimmer.dart';

class FoodCategoryItemWidget extends StatelessWidget {
  const FoodCategoryItemWidget({super.key, required this.categoryItem});

  final CategoryItem categoryItem;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = categoryItem.selected
        ? const Color(0xff2846A8).withOpacity(0.75)
        : Colors.white.withOpacity(0.05);

    return SizedBox(
      width: 80,
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: () {
              context
                  .read<CategoryBloc>()
                  .add(ToggleSelectCategory(categoryItem: categoryItem));
            },
            child: NetworkImageShimmer(
              image: categoryItem.image,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              backgroundColor: backgroundColor,
              imageWidth: 64,
              imageHeight: 64,
            ),
          ),
          Text(categoryItem.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white.withOpacity(0.75)))
        ],
      ),
    );
  }
}
