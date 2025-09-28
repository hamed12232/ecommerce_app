import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class AppBarThemes {
  AppBarThemes._();

  static const lighAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColors.dark, size: 18.0),
    actionsIconTheme: IconThemeData(color: AppColors.dark, size: 18.0),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: AppColors.white, size: 18.0),
    actionsIconTheme: IconThemeData(color: AppColors.white, size: 18.0),
  );
}
