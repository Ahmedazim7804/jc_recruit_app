import 'package:flutter/material.dart';
import 'package:jc_recruit_app/models/category.dart';
import 'package:jc_recruit_app/ui/common_widgets/network_image_shimmer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class FoodCategoryItemWidget extends StatelessWidget {
  const FoodCategoryItemWidget({super.key, required this.categoryItem});

  final CategoryItem categoryItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          NetworkImageShimmer(
            image: categoryItem.image,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            backgroundColor: Colors.white.withOpacity(0.05),
            imageWidth: 64,
            imageHeight: 64,
          ),
          Text(categoryItem.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white.withOpacity(0.75)))
        ],
      ),
    );
  }
}
