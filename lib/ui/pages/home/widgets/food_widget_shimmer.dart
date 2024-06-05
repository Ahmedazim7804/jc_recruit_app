import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:transparent_image/transparent_image.dart';

class FoodTileShimmer extends StatelessWidget {
  const FoodTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[700]!,
      highlightColor: Colors.grey[500]!,
      enabled: true,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 3,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
              visualDensity: const VisualDensity(vertical: 1.5),
              tileColor: Colors.white.withOpacity(0.05),
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              leading: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              title: Container(
                width: 75,
                height: 16,
                color: Colors.grey[300],
              ),
              subtitle: Container(
                width: 25,
                height: 16,
                color: Colors.grey[300],
                child: const Text("  "),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.shopping_cart,
                    color: Colors.white.withOpacity(0.75)),
              ));
        },
      ),
    );
  }
}
