import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getAppTheme() {
  return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color.fromARGB(255, 23, 23, 23),
      cardTheme: const CardTheme(
        color: Color(0xff181818),
      ),
      fontFamily: 'lexend');
}
