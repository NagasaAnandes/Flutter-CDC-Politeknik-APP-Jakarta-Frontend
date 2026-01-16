import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,

      // ===== Brand =====
      primary: AppColors.primary,
      onPrimary: AppColors.neutralWhite,

      secondary: AppColors.primaryDark,
      onSecondary: AppColors.neutralWhite,

      // ===== Surface (Material 3) =====
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,

      // ===== Outline =====
      outline: AppColors.divider,
      outlineVariant: AppColors.divider,

      // ===== Status =====
      error: AppColors.error,
      onError: AppColors.neutralWhite,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      colorScheme: colorScheme,

      // Scaffold mengikuti surface (Material 3)
      scaffoldBackgroundColor: colorScheme.surface,

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent, // penting di M3
      ),

      dividerTheme: DividerThemeData(color: colorScheme.outline, thickness: 1),

      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontWeight: FontWeight.w600, // Inter SemiBold
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400, // Inter Regular
        ),
        bodySmall: TextStyle(fontWeight: FontWeight.w400),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.error),
        ),
      ),
    );
  }
}
