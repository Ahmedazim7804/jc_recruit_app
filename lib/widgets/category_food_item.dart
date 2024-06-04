import 'package:flutter/material.dart';

class FoodCategoryItemWidget extends StatelessWidget {
  const FoodCategoryItemWidget(
      {super.key, required this.image, required this.name});
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Image.asset(
              image,
              width: 64,
              height: 64,
            ),
          ),
          Text(name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white.withOpacity(0.75)))
        ],
      ),
    );
  }
}
