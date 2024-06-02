import 'package:flutter/material.dart';

class DevcommLogo extends StatelessWidget {
  const DevcommLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Powered By",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.6)),
        ),
        Image.asset(
          'assets/devcommlogo_noBG.png',
          height: 64,
          width: 64,
        )
      ],
    );
  }
}
