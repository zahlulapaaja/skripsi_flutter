import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';

class AppConstants {
  static const double kTinyFontSize = 12;
  static const double kSmallFontSize = 14;
  static const double kMediumFontSize = 16;
  static const double kLargeFontSize = 20;
  static const double kHugeFontSize = 36;
  static const String fontName = 'Open Sans';

  static const headerTextStyle = TextStyle(
      color: AppColors.black,
      fontSize: AppConstants.kMediumFontSize,
      fontWeight: FontWeight.w700);

  static const textFieldHeading = TextStyle(
      color: AppColors.black,
      fontSize: AppConstants.kMediumFontSize,
      fontWeight: FontWeight.w500);

  static const textFieldHintStyle = TextStyle(
      color: AppColors.lightBlack,
      fontSize: AppConstants.kSmallFontSize,
      fontWeight: FontWeight.w300);
}
