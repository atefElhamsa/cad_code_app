import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors for Syntax Academy (Hybrid Theme)
  static const Color primaryCyan = Color(0xFF00E5FF);
  static const Color backgroundDarkNavy = Color(0xFF0F172A);

  // Gold for specific logos (like Splash)
  static const Color primaryGoldLight = Color(0xFFD4AF37);
  static const Color primaryGoldDark = Color(0xFFB8860B);

  // Light Backgrounds for Body
  static const Color backgroundLight = Color(
    0xFFF8FAFC,
  ); // Very light gray for empty states
  static const Color backgroundWhite = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textDarkNavy = Color(0xFF0F172A);
  static const Color textGray = Color(0xFF64748B);
  static const Color textWhite = Colors.white;

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryCyan, primaryCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [primaryGoldLight, primaryGoldDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: backgroundWhite,
      primaryColor: primaryCyan,
      colorScheme: const ColorScheme.light(
        primary: primaryCyan,
        secondary: backgroundDarkNavy,
        surface: backgroundWhite,
        onPrimary: backgroundWhite,
        onSurface: textDarkNavy,
      ),
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundDarkNavy,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textWhite),
        titleTextStyle: TextStyle(
          color: textWhite,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}
