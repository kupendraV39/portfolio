import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.primary,
        colorScheme: const ColorScheme.dark(
          surface: AppColors.primary,
          primary: AppColors.accent,
          secondary: AppColors.secondary,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ).apply(
          bodyColor: AppColors.white,
          displayColor: AppColors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.tertiary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: AppColors.secondary),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
        ),
      );

  // ── Text Styles (mirrors styles.ts) ──────────────────────────

  static TextStyle heroHeadText(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return GoogleFonts.poppins(
      fontSize: w < 640 ? 40 : 60,
      fontWeight: FontWeight.w900,
      color: AppColors.white,
      height: 1.1,
    );
  }

  static TextStyle heroSubText(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return GoogleFonts.poppins(
      fontSize: w < 640 ? 16 : 26,
      fontWeight: FontWeight.w500,
      color: AppColors.white100,
    );
  }

  static TextStyle sectionHeadText(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return GoogleFonts.poppins(
      fontSize: w < 640 ? 30 : 60,
      fontWeight: FontWeight.w900,
      color: AppColors.white,
    );
  }

  static TextStyle sectionSubText = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.secondary,
    letterSpacing: 1.5,
    textStyle: const TextStyle(decoration: TextDecoration.none),
  );
}
