import 'package:flutter/material.dart';

class SortOverlayWidget extends StatelessWidget {
  const SortOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        height: 20,
        width: 20,
        color: Colors.red,
        child: const Text("SDSD"),
      ),
    );
  }
}
