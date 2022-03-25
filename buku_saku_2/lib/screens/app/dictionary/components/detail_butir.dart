import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/models/dictionary_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:provider/provider.dart';

class DetailButir extends StatelessWidget {
  const DetailButir(
      {Key? key,
      required this.butir,
      this.unsurCode,
      this.unsurTitle,
      this.subUnsurCode,
      this.subUnsurTitle})
      : super(key: key);
  final String? unsurCode;
  final String? unsurTitle;
  final String? subUnsurCode;
  final String? subUnsurTitle;
  final ButirKegiatan butir;

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
                    unsurCode ?? butir.unsurCode!,
                    textAlign: TextAlign.left,
                    style: AppConstants.kDictionaryTextStyle(),
                  ),
                ),
                Expanded(
                  child: Text(
                    unsurTitle ?? butir.unsurTitle!.toUpperCase(),
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
                    subUnsurCode ?? butir.subUnsurCode!,
                    textAlign: TextAlign.left,
                    style: AppConstants.kDictionaryTextStyle(),
                  ),
                ),
                // SizedBox(width: 50, child: Text('data')),
                Expanded(
                  child: Text(
                    subUnsurTitle ?? butir.subUnsurTitle!,
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
                    butir.kode,
                    textAlign: TextAlign.left,
                    style: AppConstants.kDictionaryTextStyle(
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: Text(
                    butir.judul,
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
