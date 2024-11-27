import 'package:flutter/material.dart';
import 'package:taskify/style/AppColors.dart';

class AppStyle {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: AppColors.lightPrimary,
    ),
    scaffoldBackgroundColor: AppColors.lightBackground,
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightPrimary,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightPrimary,
      toolbarHeight: 140,
      titleTextStyle: TextStyle(
        fontFamily: "Poppins",
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 22,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      )
    ),
    textTheme: TextTheme(
      labelSmall: TextStyle(
        color: Colors.black,
        fontSize: 12,
      ),
      titleSmall: TextStyle(
        fontFamily: "Poppins",
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),

    ),
    useMaterial3: false,
  );
}
