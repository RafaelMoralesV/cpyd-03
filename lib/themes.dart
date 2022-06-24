import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static const Color utemBlue = Color.fromARGB(255, 0, 67, 130);
  static const Color utemGreen = Color.fromARGB(255, 0, 150, 86);

  static ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: utemBlue,
          primary: utemBlue,
          secondary: utemGreen,
        ),
        textTheme: TextTheme(
          headline1: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headline2: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            // color: const Color(0xff3e3e3e),
          ),
          headline3: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            // color: const Color(0xff3e3e3e),
          ),
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
