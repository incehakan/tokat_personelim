import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData appTheme = ThemeData(
  primaryColor: AppColors.sunsetOrange,
  scaffoldBackgroundColor: AppColors.selago,
  tabBarTheme: const TabBarThemeData(
    indicatorColor: AppColors.sunsetOrange,
    unselectedLabelStyle: TextStyle(
      fontSize: 12,
      color: AppColors.kashmirBlue,
    ),
    labelStyle: TextStyle(
      fontSize: 12,
      color: AppColors.sunsetOrange,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.selago,
    foregroundColor: AppColors.lynch,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: AppColors.lynch,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.selago,
    selectedItemColor: AppColors.sunsetOrange,
  ),
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStatePropertyAll<Color>(
        AppColors.sunsetOrange,
      ),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.sunsetOrange,
      ),
    ),
    hintStyle: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
  ),
);
