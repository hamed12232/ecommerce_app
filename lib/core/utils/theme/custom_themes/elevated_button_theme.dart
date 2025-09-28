import 'package:flutter/material.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();
  static final lightElevatedButtonTheme  = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.dark,
      side: const BorderSide(color: AppColors.dark),
      padding: const EdgeInsets.symmetric(vertical: TSizes.buttonHeight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.dark,
      backgroundColor: AppColors.primary,
      side: const BorderSide(color: AppColors.primary),
      padding: const EdgeInsets.symmetric(vertical: TSizes.buttonHeight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
    ),
  );
}