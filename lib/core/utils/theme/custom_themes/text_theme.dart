import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  AppTextTheme._();
  

  /* -- Light Text Theme -- */
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(fontSize: 28.0, fontWeight: FontWeight.bold, color: AppColors.dark),
    displayMedium: GoogleFonts.poppins(fontSize: 24.0, fontWeight: FontWeight.w700, color: AppColors.dark),
    displaySmall: GoogleFonts.poppins(fontSize: 24.0, fontWeight: FontWeight.normal, color: AppColors.dark),
    headlineMedium: GoogleFonts.poppins(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors.dark),
    headlineSmall: GoogleFonts.poppins(fontSize: 18.0, fontWeight: FontWeight.normal, color: AppColors.dark),
    titleLarge: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w600, color: AppColors.dark),
    bodyLarge: GoogleFonts.poppins(fontSize: 14.0, color: AppColors.dark),
    bodyMedium: GoogleFonts.poppins(fontSize: 14.0, color: AppColors.dark.withValues(alpha: 0.8)),
  );

  /* -- Dark Text Theme -- */
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(fontSize: 28.0, fontWeight: FontWeight.bold, color: AppColors.white),
    displayMedium: GoogleFonts.poppins(fontSize: 24.0, fontWeight: FontWeight.w700, color: AppColors.white),
    displaySmall: GoogleFonts.poppins(fontSize: 24.0, fontWeight: FontWeight.normal, color: AppColors.white),
    headlineMedium: GoogleFonts.poppins(fontSize: 18.0, fontWeight: FontWeight.w600, color: AppColors.white),
    headlineSmall: GoogleFonts.poppins(fontSize: 18.0, fontWeight: FontWeight.normal, color: AppColors.white),
    titleLarge: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w600, color: AppColors.white),
    bodyLarge: GoogleFonts.poppins(fontSize: 14.0, color: AppColors.white),
    bodyMedium: GoogleFonts.poppins(fontSize: 14.0, color: AppColors.white.withValues(alpha: 0.8)),
  );
  
}