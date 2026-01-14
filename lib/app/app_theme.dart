import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._(); // prevent instantiation

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,

      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF1565C0), // Biru institusi (placeholder)
        brightness: Brightness.light,
      ),

      scaffoldBackgroundColor: Colors.white,

      appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),

      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontSize: 14),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
