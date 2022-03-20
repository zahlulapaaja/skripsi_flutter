import 'package:buku_saku_2/screens/app/models/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:provider/provider.dart';

class DetailButir extends StatelessWidget {
  const DetailButir(
      {Key? key, required this.butirCode, required this.butirTitle})
      : super(key: key);
  final String butirCode;
  final String butirTitle;

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
                    context.read<ScreenProvider>().selectedUnsurCode,
                    textAlign: TextAlign.left,
                    style: AppConstants.kDictionaryTextStyle(),
                  ),
                ),
                Expanded(
                  child: Text(
                    context.read<ScreenProvider>().selectedUnsur.toUpperCase(),
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
                    context.read<ScreenProvider>().selectedSubUnsurCode,
                    textAlign: TextAlign.left,
                    style: AppConstants.kDictionaryTextStyle(),
                  ),
                ),
                // SizedBox(width: 50, child: Text('data')),
                Expanded(
                  child: Text(
                    context.read<ScreenProvider>().selectedSubUnsur,
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
                    butirCode,
                    textAlign: TextAlign.left,
                    style: AppConstants.kDictionaryTextStyle(
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: Text(
                    butirTitle,
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
