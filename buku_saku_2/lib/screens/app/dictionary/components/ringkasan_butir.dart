import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:provider/provider.dart';

class RingkasanButir extends StatelessWidget {
  const RingkasanButir({
    Key? key,
    required this.code,
    required this.jenjang,
    required this.angkaKredit,
    this.persenAK,
  }) : super(key: key);
  final String code;
  final String jenjang;
  final double angkaKredit;
  final double? persenAK;

  @override
  Widget build(BuildContext context) {
    int targetAK = context.watch<ProfileProvider>().akNaikPangkat;

    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.info,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  code,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontFamily: AppConstants.fontName,
                    color: AppColors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "( " + jenjang + " )",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontFamily: AppConstants.fontName,
                    color: AppColors.black,
                    fontSize: AppConstants.kSmallFontSize,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Text(
              // todo : ini keknya ga perlu bikin ternary
              persenAK != null
                  ? angkaKredit.toStringAsFixed(3)
                  : (angkaKredit * targetAK).toStringAsFixed(3),
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontFamily: AppConstants.fontName,
                color: AppColors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
