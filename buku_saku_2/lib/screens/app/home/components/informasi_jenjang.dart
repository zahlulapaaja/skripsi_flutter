import 'package:buku_saku_2/configs/components.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:buku_saku_2/screens/app/models/target_angka_kredit.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:provider/provider.dart';

class InformasiJenjang extends StatelessWidget {
  const InformasiJenjang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TargetAngkaKredit pangkatSaatIni =
        context.watch<ProfileProvider>().pangkatSaatIni;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 14.0, right: 14.0, top: 14.0),
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!pangkatSaatIni.pangkatPuncak!)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Butuh ',
                          style: AppConstants.kTextFieldTextStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text: NumberFormatter.convertToId(
                                    pangkatSaatIni.akNaikPangkat),
                                style: AppConstants.kNormalTitleTextStyle),
                            const TextSpan(
                                text: ' Angka Kredit menuju Golongan '),
                            TextSpan(
                                text: pangkatSaatIni.golonganSelanjutnya,
                                style: AppConstants.kNormalTitleTextStyle),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (!pangkatSaatIni.pangkatPuncak!)
                SizedBox(
                  width: 10,
                  child: Center(
                    child: Container(
                      margin:
                          const EdgeInsetsDirectional.only(start: 1, end: 1),
                      width: 3,
                      height: 60,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: (pangkatSaatIni.id! > 12)
                          ? const TextSpan(
                              text: 'Anda berada di puncak jenjang')
                          : TextSpan(
                              text: 'Butuh ',
                              style: AppConstants.kTextFieldTextStyle,
                              children: <TextSpan>[
                                TextSpan(
                                    text: (pangkatSaatIni.pangkatPuncak!)
                                        ? NumberFormatter.convertToId(
                                            pangkatSaatIni.akNaikPangkat)
                                        : NumberFormatter.convertToId(
                                            pangkatSaatIni.akNaikJenjang!),
                                    style: AppConstants.kNormalTitleTextStyle),
                                const TextSpan(text: ' Angka Kredit menuju '),
                                TextSpan(
                                    text: pangkatSaatIni.jenjangSelanjutnya,
                                    style: AppConstants.kNormalTitleTextStyle),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
              left: 14.0, right: 14.0, top: 14.0, bottom: 30.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
                child: Text(
                  'Syarat Naik Pangkat',
                  textAlign: TextAlign.start,
                  style: AppConstants.kNormalTitleTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, bottom: 10, right: 10),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(1),
                  },
                  border: const TableBorder(
                      horizontalInside: BorderSide(
                    width: 1,
                    color: AppColors.lightGrey,
                    style: BorderStyle.solid,
                  )),
                  children: <TableRow>[
                    TableRow(children: [
                      const TableCell(
                        verticalAlignment: TableCellVerticalAlignment.middle,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 14, bottom: 10, right: 10),
                          child: Text(
                            'Angka Kredit (2/3 dari unsur utama)',
                            style: AppConstants.kDetailCardTextStyle,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Text(
                          ">= ${pangkatSaatIni.akNaikPangkat.toString()}",
                          style: AppConstants.kCardTitleTextStyle,
                        ),
                      ),
                    ]),
                    if (pangkatSaatIni.pangkatPuncak!)
                      TableRow(children: [
                        const TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 14, bottom: 10, right: 10),
                            child: Text(
                              'Angka Kredit Pemeliharaan (per tahun)',
                              style: AppConstants.kDetailCardTextStyle,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            ": ${pangkatSaatIni.akPemeliharaan.toString()}",
                            style: AppConstants.kCardTitleTextStyle,
                          ),
                        ),
                      ]),
                    if (pangkatSaatIni.pengembanganProfesi != null)
                      TableRow(children: [
                        const TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 14, bottom: 10, right: 10),
                            child: Text(
                              'Angka Kredit Pengembangan Profesi (untuk naik jenjang)',
                              style: AppConstants.kDetailCardTextStyle,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            ">= ${pangkatSaatIni.pengembanganProfesi.toString()}",
                            style: AppConstants.kCardTitleTextStyle,
                          ),
                        ),
                      ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
