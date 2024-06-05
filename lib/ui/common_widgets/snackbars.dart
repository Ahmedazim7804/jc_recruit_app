import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class MyFlushBars {
  static Flushbar addToCartFlushBar({required bool success}) {
    String titleText = success ? "Done successfully" : "Error";
    String messageText =
        success ? "Item added to cart" : "Error adding item to cart";
    IconData iconData = success ? Icons.check_circle : Icons.cancel;
    Color backgroundColor =
        success ? const Color(0xff376e37) : const Color(0xff931616);

    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: backgroundColor,
      isDismissible: true,
      duration: const Duration(seconds: 2),
      icon: Icon(
        iconData,
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      borderRadius: BorderRadius.circular(16),
      titleText: Text(
        titleText,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        messageText,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white.withOpacity(0.95),
        ),
      ),
    );
  }
}
