import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// Manages app-wide theme configuration
// This class manages the app's visual theme settings using Material Design 3
class AppTheme {
  // Private constructor prevents creating instances of this utility class
  // This is a good practice when the class only contains static members
  AppTheme._();

  /// Light theme configuration - used when the device is in light mode
  static final ThemeData lightTheme = ThemeData(
    // Enables Material Design 3 features
    useMaterial3: true,
    // Sets the overall brightness to light
    brightness: Brightness.light,
    // Defines the primary color for light theme
    primaryColor: AppColors.primaryLight,
    // Sets the background color for all scaffold widgets
    scaffoldBackgroundColor: AppColors.backgroundLight,

    // AppBar configuration for light theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryLight,
      // Removes shadow beneath the app bar
      elevation: 0,
      // Centers the title in the app bar
      centerTitle: true,
      // Uses predefined text style with specific color for app bar title
      titleTextStyle: AppTextStyles.appBarTitle.copyWith(
        color: AppColors.textDark,
      ),
    ),

    // Card widget configuration for light theme
    cardTheme: CardTheme(
      color: AppColors.surfaceLight,
      // Adds subtle elevation to cards
      elevation: 2,
      // Rounds the corners of cards with a 12-pixel radius
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // Text styles configuration for light theme
    textTheme: TextTheme(
      // Applies predefined text styles for different text categories
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
    ).apply(
      // Applies consistent text colors across all text styles
      bodyColor: AppColors.textDark,
      displayColor: AppColors.textDark,
    ),
  );

  /// Dark theme configuration - similar structure but with dark mode colors
  // The dark theme follows the same pattern as light theme but uses dark-specific colors
  static final ThemeData darkTheme = ThemeData(
    // Similar configuration as light theme but with dark mode specific colors
    // Each property serves the same purpose as in light theme
    // but uses colors optimized for dark mode viewing

  useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    // App Bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.appBarTitle.copyWith(
        color: AppColors.textLight,
      ),
    ),
    // Card theme
    cardTheme: CardTheme(
      color: AppColors.surfaceDark,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    // Text theme
    textTheme: TextTheme(
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
    ).apply(
      bodyColor: AppColors.textLight,
      displayColor: AppColors.textLight,
    ),
  );
}