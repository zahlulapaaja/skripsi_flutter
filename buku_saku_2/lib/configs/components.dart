import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';

class BlueRoundedButton extends StatelessWidget {
  final String buttonTitle;
  final Function() onPressed;
  final ButtonStyle? style;
  final double height;

  const BlueRoundedButton({
    Key? key,
    required this.buttonTitle,
    required this.onPressed,
    this.style,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: <Color>[
            AppColors.primary,
            AppColors.primaryLight, // ini 45 persen opacity
          ],
          begin: Alignment.center,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          minimumSize: MaterialStateProperty.all(Size.fromHeight(height)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: Text(
          buttonTitle.toUpperCase(),
          style: const TextStyle(
            color: AppColors.offWhite,
            fontSize: AppConstants.kLargeFontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class FormFieldTemplate extends StatelessWidget {
  final String headingText;
  final String hintText;
  final bool obsecureText;
  final Widget suffixIcon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final int maxLines;
  final bool elevation;
  final Border? border;

  const FormFieldTemplate({
    Key? key,
    required this.headingText,
    required this.hintText,
    required this.obsecureText,
    required this.suffixIcon,
    required this.textInputType,
    required this.textInputAction,
    required this.controller,
    required this.maxLines,
    this.elevation = true,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            headingText,
            style: AppConstants.kTextFieldHeader,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightGrey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
            border: border,
            boxShadow: elevation
                ? [
                    BoxShadow(
                      color: AppColors.grey.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              maxLines: maxLines,
              controller: controller,
              textInputAction: textInputAction,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: textInputType,
              obscureText: obsecureText,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppConstants.kTextFieldHintStyle,
                border: InputBorder.none,
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        )
      ],
    );
  }
}
