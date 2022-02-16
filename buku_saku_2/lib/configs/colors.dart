import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF006599);
  static const Color primaryLight = Color(0xFF1199CB);
  static const Color primaryDark = Color(0xFF012233);

  static const Color secondary = Color(0xFF990100);
  static const Color secondaryDark = Color(0xFF540010);

  static const Color alert = Color(0xFFF03613);
  static const Color warning = Color(0xFFEDC02C);
  static const Color success = Color(0xFF27B46E);
  static const Color info = Color(0xFFAFDDF7);
  static const Color beige = Color(0xFFF3E2B3);

  static const Color black = Color(0xFF1E1E1E);
  static const Color lightBlack = Color(0xFF616161);
  static const Color grey = Color(0xFFAFB1B2);
  static const Color lightGrey = Color(0xFFCCCCCC);
  static const Color midWhite = Color(0xFFF1F1F1);
  static const Color offWhite = Color(0xFFF8F8F8);

  static const LinearGradient kGradientBackground = LinearGradient(
    colors: [
      primary,
      primaryLight,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
  );
}
