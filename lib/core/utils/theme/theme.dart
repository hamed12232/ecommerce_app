import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/theme/custom_themes/app_bar_theme.dart';
import 'package:ecommerce_app/core/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:ecommerce_app/core/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:ecommerce_app/core/utils/theme/custom_themes/text_field_theme.dart';
import 'package:ecommerce_app/core/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBackground,
    brightness: Brightness.light,
    textTheme: AppTextTheme.lightTextTheme,
    appBarTheme: AppBarThemes.lighAppBarTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: OutlinedButtonThemes.lighOutlinedButtonThemes,
    inputDecorationTheme: TextFormFieldThemes.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBackground,
    brightness: Brightness.dark,
    textTheme: AppTextTheme.darkTextTheme,
    appBarTheme: AppBarThemes.darkAppBarTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: OutlinedButtonThemes.darkOutlinedButtonTheme,
    inputDecorationTheme: TextFormFieldThemes.darkInputDecorationTheme,
  );
}