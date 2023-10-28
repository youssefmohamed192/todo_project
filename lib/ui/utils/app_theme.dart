import 'package:flutter/material.dart';
import 'package:todo_project/provider/list_provider.dart';
import 'package:todo_project/ui/utils/app_colors.dart';

abstract class AppTheme {
  static const TextStyle appBarTextStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.white);
  static const TextStyle taskTittleTextStyle = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.primary);
  static const TextStyle taskDescriptionTextStyle = TextStyle(
      fontWeight: FontWeight.normal, fontSize: 18, color: AppColors.lightBlack);
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
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: StadiumBorder(
            side: BorderSide(
                style: BorderStyle.solid, color: AppColors.white, width: 4)),
      ),
      // dividerTheme: DividerThemeData(thickness: 3, color: AppColors.primary)
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primary,
    appBarTheme:  AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      titleTextStyle: appBarTextStyle.copyWith(color: AppColors.accentDark),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(size: 32),
        unselectedIconTheme: IconThemeData(size: 32),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        backgroundColor: AppColors.thirdColor),
    scaffoldBackgroundColor: AppColors.accentDark,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: StadiumBorder(
          side: BorderSide(
              style: BorderStyle.solid, color: AppColors.thirdColor, width: 4)),
    ),
  );
}
