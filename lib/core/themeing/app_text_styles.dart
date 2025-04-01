import 'package:flutter/material.dart';
import 'package:flutter_news_app_api/core/themeing/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles{
  static TextStyle font18SemiBoldwhite = GoogleFonts.nunitoSans(fontSize: 18,
      fontWeight: FontWeight.w600,color: AppColors.whiteColor);
  static TextStyle font23Boldwhite = GoogleFonts.nunitoSans(fontSize: 23,
      fontWeight: FontWeight.bold,color: AppColors.whiteColor);
  static TextStyle font12SemiBoldgreen = GoogleFonts.nunitoSans(fontSize: 12,
      fontWeight: FontWeight.w600,color: AppColors.greenColor);
  static TextStyle font12requlargreyDark = GoogleFonts.nunitoSans(fontSize: 12,
      fontWeight: FontWeight.w400,color: AppColors.greyColor);
  static TextStyle font12reqularwhite = GoogleFonts.nunitoSans(fontSize: 12,
      fontWeight: FontWeight.w400,color: Colors.white);
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
}
