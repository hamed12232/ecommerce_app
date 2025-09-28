
import 'package:flutter/material.dart';

class AppBarThemes{
  AppBarThemes._();

  static const lighAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: TColors.dark, size: 18.0),
    actionsIconTheme: IconThemeData(color: TColors.dark, size: 18.0),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: TColors.white, size: 18.0),
    actionsIconTheme: IconThemeData(color: TColors.white, size: 18.0),
  );
}