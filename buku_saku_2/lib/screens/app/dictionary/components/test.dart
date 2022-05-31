import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';

class TestButir extends StatelessWidget {
  const TestButir({
    Key? key,
    required this.butir,
  }) : super(key: key);
  final ButirKegiatan butir;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Satuan Hasil',
              style: AppConstants.kDictionaryTextStyle(
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Text(
              butir.satuanHasil,
              style: AppConstants.kDictionaryTextStyle(),
            ),
            const SizedBox(height: 12),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Angka Kredit',
              style: AppConstants.kDictionaryTextStyle(
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Text(
              butir.angkaKredit.toStringAsFixed(3),
              style: AppConstants.kDictionaryTextStyle(),
            ),
            const SizedBox(height: 12),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Batasan Penilaian',
              style: AppConstants.kDictionaryTextStyle(
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Text(
              butir.batasanPenilaian == "" ? "-" : butir.batasanPenilaian,
              style: AppConstants.kDictionaryTextStyle(),
            ),
            const SizedBox(height: 12),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Pelaksana',
              style: AppConstants.kDictionaryTextStyle(
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Text(
              butir.pelaksana,
              style: AppConstants.kDictionaryTextStyle(),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ],
    );
  }
}
