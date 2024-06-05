import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NetworkImageShimmer extends StatelessWidget {
  NetworkImageShimmer(
      {super.key,
      required this.image,
      required this.imageWidth,
      required this.imageHeight,
      this.fit,
      this.backgroundColor = Colors.transparent,
      EdgeInsets? padding}) {
    padding = padding ?? const EdgeInsets.all(0);
    shimmerWidth = imageWidth + padding.horizontal;
    shimmerHeight = imageWidth + padding.vertical;
    this.padding = padding;
  }

  final String image;
  final int imageWidth;
  final int imageHeight;
  final Color backgroundColor;
  final BoxFit? fit;

  late final EdgeInsets padding;
  late final double shimmerWidth;
  late final double shimmerHeight;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return Container(
              padding: padding,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: child);
        }

        return Shimmer.fromColors(
          baseColor: Colors.grey[700]!,
          highlightColor: Colors.grey[500]!,
          child: Container(
            width: shimmerWidth.toDouble(),
            height: shimmerHeight.toDouble(),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      width: imageWidth.toDouble(),
      height: imageHeight.toDouble(),
    );
  }
}
