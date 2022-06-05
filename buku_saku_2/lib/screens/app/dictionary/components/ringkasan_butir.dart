import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';

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
  final bool? persenAK;

  @override
  Widget build(BuildContext context) {
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
              persenAK != true
                  ? angkaKredit.toStringAsFixed(3)
                  : (angkaKredit * 100).toInt().toString() +
                      '% AK\nNaik Pangkat',
              textAlign: TextAlign.end,
              style: TextStyle(
                fontFamily: AppConstants.fontName,
                color: AppColors.black,
                fontSize: persenAK != true ? 24 : 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
