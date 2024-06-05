import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class AuthErrorDialog extends StatelessWidget {
  const AuthErrorDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black.withAlpha(220),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/lottie/error.json',
              repeat: false,
              height: 100,
            ),
            Text(message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 16,
                )),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 6,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                  backgroundColor: const Color(0xffF97479),
                ),
                child: Text(
                  "Try again",
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }

  static void show(BuildContext ctx, String message) {
    showDialog(
        context: ctx,
        builder: (context) {
          return AuthErrorDialog(message: message);
        });
  }
}
