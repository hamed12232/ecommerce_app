import 'package:flutter/material.dart';

class OutlinedButtonThemes {
  OutlinedButtonThemes._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lighOutlinedButtonThemes = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: TColors.secondary,
      side: const BorderSide(color: TColors.secondary),
      padding: const EdgeInsets.symmetric(vertical: TSizes.buttonHeight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: TColors.white,
      side: const BorderSide(color: TColors.white),
      padding: const EdgeInsets.symmetric(vertical: TSizes.buttonHeight),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TSizes.borderRadiusLg)),
    ),
  );
}
