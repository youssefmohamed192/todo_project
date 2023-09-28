import 'package:flutter/material.dart';
import 'package:todo_project/ui/utils/app_colors.dart';

abstract class AppTheme {
  static const TextStyle appBarTextStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.white);
  static const TextStyle taskTittleTextStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.primary);
  static const TextStyle taskDescriptionTextStyle = TextStyle(
      fontWeight: FontWeight.normal, fontSize: 20, color: AppColors.lightBlack);
  static const TextStyle bottomSheetTittleTextStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.black);

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      titleTextStyle: appBarTextStyle,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(size: 32),
        unselectedIconTheme: IconThemeData(size: 32),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey),
    scaffoldBackgroundColor: AppColors.accent,
  );

  static ThemeData darkTheme = ThemeData();
}
