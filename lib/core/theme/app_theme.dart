import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData.light();
    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFF0B1F3A),
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
      colorScheme: base.colorScheme.copyWith(
        primary: const Color(0xFF176BFF),
        secondary: const Color(0xFFFFB800),
      ),
    );
  }

  static ThemeData get dark {
    final base = ThemeData.dark();
    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFF0B1F3A),
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
      colorScheme: base.colorScheme.copyWith(
        primary: const Color(0xFF176BFF),
        secondary: const Color(0xFFFFB800),
      ),
    );
  }
}
