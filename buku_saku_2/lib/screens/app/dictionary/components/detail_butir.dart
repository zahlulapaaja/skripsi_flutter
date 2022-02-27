import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/components/card_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailButir extends StatelessWidget {
  const DetailButir({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.info,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 75,
                  child: Text(
                    'I',
                    textAlign: TextAlign.left,
                    style: AppConstants.kDictionaryTextStyle(),
                  ),
                ),
                // SizedBox(width: 50, child: Text('data')),
                Expanded(
                  child: Text(
                    'tata kelola dan tata laksana teknologi informasi'
                        .toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppConstants.kDictionaryTextStyle(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 7),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 75,
                  child: Text(
                    'I.B',
                    textAlign: TextAlign.left,
                    style: AppConstants.kDictionaryTextStyle(),
                  ),
                ),
                // SizedBox(width: 50, child: Text('data')),
                Expanded(
                  child: Text(
                    'Pengelolaan Data (Data Management)',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppConstants.kDictionaryTextStyle(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 75,
                  child: Text(
                    'I.B.27',
                    textAlign: TextAlign.left,
                    style: AppConstants.kDictionaryTextStyle(
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Melakukan Pemantauan (Monitoring) Implementasi Prosedur Pengelolaan Kualitas Data',
                    style: AppConstants.kDictionaryTextStyle(
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
