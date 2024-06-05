import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CartTileShimmer extends StatelessWidget {
  const CartTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
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
        trailing: Container(
          width: 100,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: const Color(0xff2846A8),
          ),
        ));
  }
}
