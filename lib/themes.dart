import 'package:flutter/material.dart';

class CustomTheme {
  static const Color utemBlue = Color.fromARGB(255, 0, 67, 130);
  static const Color utemGreen = Color.fromARGB(255, 0, 150, 86);

  static ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: utemBlue,
          primary: utemBlue,
          secondary: Color.lerp(utemBlue, utemGreen, 0.4),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: utemBlue,
          primary: utemBlue,
          secondary: utemGreen,
        ),
      );
}
