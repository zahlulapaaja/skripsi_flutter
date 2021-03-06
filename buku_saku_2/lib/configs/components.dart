import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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

class AppComponents {
  static void toastAlert({required String msg, required Color color}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color.withOpacity(0.9),
      textColor: AppColors.offWhite,
      fontSize: AppConstants.kTinyFontSize,
    );
  }

  static String convertNumberToId(dynamic number) {
    NumberFormat numberFormatter = NumberFormat("#0.000", 'id_ID');
    return numberFormatter.format(number);
  }
}
