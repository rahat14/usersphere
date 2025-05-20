import 'package:flutter/material.dart';
import 'app_colors.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.backgroundLight,
  colorScheme: const ColorScheme.light().copyWith(
    primary: AppColors.primary,
    secondary: AppColors.accent,
    surface: AppColors.backgroundLight,
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.text),
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.text),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.text),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.text),
    bodyMedium: TextStyle(fontSize: 14,fontWeight: FontWeight.w400, color: AppColors.textSubTitle),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.backgroundLight,
    foregroundColor: AppColors.text,
    elevation: 0,
  ),
);

