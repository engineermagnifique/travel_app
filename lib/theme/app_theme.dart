import 'package:flutter/material.dart';

class AppTheme {
  // ── Core Palette ──────────────────────────────────────────────
  static const Color primary      = Color(0xFF2EC4A5);   // teal-mint
  static const Color primaryDark  = Color(0xFF1A9E84);
  static const Color primaryLight = Color(0xFFE8FAF6);
  static const Color accent       = Color(0xFFFF6B6B);   // warm coral
  static const Color gold         = Color(0xFFFFB830);   // star / rating
  static const Color dark         = Color(0xFF1A2332);
  static const Color grey         = Color(0xFF8A94A6);
  static const Color greyLight    = Color(0xFFF4F6FA);
  static const Color white        = Color(0xFFFFFFFF);
  static const Color cardShadow   = Color(0x14000000);

  // ── Gradients ─────────────────────────────────────────────────
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2EC4A5), Color(0xFF1A9E84)],
  );

  static const LinearGradient cardOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0xCC1A2332)],
  );

  static const LinearGradient imageOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00000000), Color(0x99000000)],
  );

  // ── Typography ────────────────────────────────────────────────
  static const String fontFamily = 'Poppins';

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: greyLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: dark),
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: dark,
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.w800, color: dark, height: 1.2,
        ),
        displayMedium: TextStyle(
          fontSize: 26, fontWeight: FontWeight.w700, color: dark, height: 1.3,
        ),
        headlineLarge: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w700, color: dark,
        ),
        headlineMedium: TextStyle(
          fontSize: 18, fontWeight: FontWeight.w600, color: dark,
        ),
        bodyLarge: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w400, color: grey, height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 13, fontWeight: FontWeight.w400, color: grey, height: 1.5,
        ),
        labelLarge: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: white,
          letterSpacing: 0.5,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: grey, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: greyLight,
        selectedColor: primary,
        labelStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }

  // ── Shadow Presets ────────────────────────────────────────────
  static List<BoxShadow> get cardShadows => [
    BoxShadow(
      color: Colors.black.withOpacity(0.07),
      blurRadius: 20,
      offset: const Offset(0, 6),
    ),
  ];

  static List<BoxShadow> get buttonShadows => [
    BoxShadow(
      color: primary.withOpacity(0.4),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];
}
