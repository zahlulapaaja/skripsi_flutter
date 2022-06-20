import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';

class AppConstants {
  /// Font
  static const String fontName = 'Open Sans';

  static const double kTinyFontSize = 12;
  static const double kSmallFontSize = 14;
  static const double kNormalFontSize = 16;
  static const double kLargeFontSize = 20;
  static const double kHugeFontSize = 36;

  static const kNavHeaderTextStyle = TextStyle(
    fontFamily: fontName,
    color: AppColors.offWhite,
    fontSize: kLargeFontSize,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
  );

  static const kSmallWhiteTextStyle = TextStyle(
    fontFamily: fontName,
    color: AppColors.offWhite,
    fontSize: kSmallFontSize,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.5,
  );

  /// Card
  static const kCardTitleTextStyle = TextStyle(
    fontFamily: fontName,
    color: AppColors.black,
    fontSize: kSmallFontSize,
    fontWeight: FontWeight.w700,
  );

  static const kCardBodyTextStyle = TextStyle(
    fontFamily: fontName,
    color: AppColors.black,
    fontSize: kSmallFontSize - 1,
    fontWeight: FontWeight.w500,
    height: 1.1,
  );

  static const kCardDateTextStyle = TextStyle(
    fontFamily: fontName,
    color: AppColors.grey,
    fontSize: kSmallFontSize,
    fontWeight: FontWeight.normal,
  );

  static const kDetailCardTextStyle = TextStyle(
    fontFamily: fontName,
    color: AppColors.black,
    fontSize: kNormalFontSize - 1,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.normal,
  );

  /// Dictionary
  static const kNormalTitleTextStyle = TextStyle(
    fontFamily: fontName,
    color: AppColors.black,
    fontSize: kNormalFontSize,
    fontWeight: FontWeight.w700,
  );

  static const kLargeTitleTextStyle = TextStyle(
    fontFamily: fontName,
    color: AppColors.black,
    fontSize: kLargeFontSize,
    fontWeight: FontWeight.w700,
  );

  static const kDictTitleTextStyle = TextStyle(
    fontFamily: fontName,
    color: AppColors.grey,
    fontSize: kSmallFontSize,
    fontWeight: FontWeight.w700,
  );

  static TextStyle kDictionaryTextStyle(
      {FontWeight? fontWeight = FontWeight.w500}) {
    return TextStyle(
      fontFamily: fontName,
      color: AppColors.black,
      fontSize: kSmallFontSize,
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
  static const kSearchboxDecoration = InputDecoration(
    hintText: "Masukkan kata kunci...",
    hintStyle: TextStyle(
      fontFamily: fontName,
      color: AppColors.grey,
      fontSize: kSmallFontSize,
      fontWeight: FontWeight.normal,
    ),
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
  );

  static kTextFieldDecoration(
      {String? hintText,
      required BorderSide borderSide,
      EdgeInsets? contentPadding = const EdgeInsets.only(left: 10)}) {
    return InputDecoration(
      isDense: true,
      hintText: hintText,
      contentPadding: contentPadding,
      border: OutlineInputBorder(
        borderSide: borderSide,
      ),
      hintStyle: kTextFieldHintStyle,
    );
  }

  static const kTextFieldTextStyle = TextStyle(
    fontFamily: fontName,
    color: AppColors.black,
    fontSize: kNormalFontSize,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.normal,
  );

  static const kTextFieldHeader = TextStyle(
    color: AppColors.black,
    fontSize: kNormalFontSize,
    fontWeight: FontWeight.w500,
  );

  static const kTextFieldHintStyle = TextStyle(
    color: AppColors.grey,
    fontSize: kSmallFontSize,
    fontWeight: FontWeight.normal,
  );

  static const kFieldLabel = TextStyle(
    fontFamily: fontName,
    color: AppColors.grey,
    fontSize: kSmallFontSize,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
}
