import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';

class AppConstants {
  /// Tentang font
  static const String fontName = 'Open Sans';

  static const double kTinyFontSize = 12;
  static const double kSmallFontSize = 14;
  static const double kNormalFontSize = 16;
  static const double kLargeFontSize = 20;
  static const double kHugeFontSize = 36;

  static const kNavHeaderTextStyle = TextStyle(
    fontFamily: AppConstants.fontName,
    color: AppColors.offWhite,
    fontSize: AppConstants.kLargeFontSize,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
  );

  static const kHeaderTextStyle = TextStyle(
    fontFamily: AppConstants.fontName,
    color: AppColors.offWhite,
    fontSize: AppConstants.kLargeFontSize + 4,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.0,
  );

  static const kTitleViewTextStyle = TextStyle(
    fontFamily: AppConstants.fontName,
    color: AppColors.grey,
    fontSize: AppConstants.kNormalFontSize,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );

  static const kTitleActiveTextStyle = TextStyle(
    fontFamily: AppConstants.fontName,
    color: AppColors.black,
    fontSize: AppConstants.kNormalFontSize,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.5,
  );

  static const kDetailBtnTextStyle = TextStyle(
    fontFamily: AppConstants.fontName,
    color: AppColors.offWhite,
    fontSize: AppConstants.kTinyFontSize + 2,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.5,
  );

  /// Card
  static const kCardTitleTextStyle = TextStyle(
    fontFamily: AppConstants.fontName,
    color: AppColors.black,
    fontSize: AppConstants.kSmallFontSize,
    fontWeight: FontWeight.w700,
  );

  static const kCardBodyTextStyle = TextStyle(
    fontFamily: AppConstants.fontName,
    color: AppColors.black,
    fontSize: AppConstants.kSmallFontSize - 1,
    fontWeight: FontWeight.w500,
    height: 1.1,
  );

  static const kCardDateTextStyle = TextStyle(
    fontFamily: AppConstants.fontName,
    color: AppColors.grey,
    fontSize: AppConstants.kSmallFontSize,
    fontWeight: FontWeight.normal,
  );

  /// Dictionary

  static const kNormalTitleTextStyle = TextStyle(
    fontFamily: AppConstants.fontName,
    color: AppColors.black,
    fontSize: AppConstants.kNormalFontSize,
    fontWeight: FontWeight.w700,
  );

  static const kLargeTitleTextStyle = TextStyle(
    fontFamily: AppConstants.fontName,
    color: AppColors.black,
    fontSize: AppConstants.kLargeFontSize,
    fontWeight: FontWeight.w700,
  );

  static const kDictTitleTextStyle = TextStyle(
    fontFamily: AppConstants.fontName,
    color: AppColors.grey,
    fontSize: AppConstants.kSmallFontSize,
    fontWeight: FontWeight.w700,
  );

  static TextStyle kDictionaryTextStyle(
      {FontWeight? fontWeight = FontWeight.w500}) {
    return TextStyle(
      fontFamily: AppConstants.fontName,
      color: AppColors.black,
      fontSize: AppConstants.kSmallFontSize,
      fontWeight: fontWeight,
    );
  }

  static ButtonStyle kDictBtnStyle = TextButton.styleFrom(
    backgroundColor: AppColors.info,
    padding: const EdgeInsets.all(10.0),
    alignment: Alignment.center,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );

  /// Text Field
  static const kTextFieldDecoration = InputDecoration(
    hintText: "Masukkan kata kunci...",
    hintStyle: TextStyle(
      fontFamily: AppConstants.fontName,
      color: AppColors.grey,
      fontSize: AppConstants.kSmallFontSize,
      fontWeight: FontWeight.normal,
    ),
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
  );

  static const kTextFieldTextStyle = TextStyle(
    fontFamily: AppConstants.fontName,
    color: AppColors.black,
    fontSize: AppConstants.kNormalFontSize,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.normal,
  );

  static const kTextFieldHeader = TextStyle(
    color: AppColors.black,
    fontSize: AppConstants.kNormalFontSize,
    fontWeight: FontWeight.w500,
  );

  static const kTextFieldHintStyle = TextStyle(
    color: AppColors.lightBlack,
    fontSize: AppConstants.kSmallFontSize,
    fontWeight: FontWeight.w300,
  );

  static const kFieldLabel = TextStyle(
    fontFamily: AppConstants.fontName,
    color: AppColors.grey,
    fontSize: AppConstants.kSmallFontSize,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
}
