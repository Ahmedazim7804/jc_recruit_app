import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryWidgetShimmer extends StatelessWidget {
  const CategoryWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[700]!,
        highlightColor: Colors.grey[500]!,
        child: Wrap(
          spacing: 12,
          children: Iterable<int>.generate(4).toList().map((_) {
            return SizedBox(
              width: 80,
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  Container(
                    width: 64,
                    height: 10,
                    margin: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                    color: Colors.grey[300],
                  )
                ],
              ),
            );
          }).toList(),
        ));
  }
}
