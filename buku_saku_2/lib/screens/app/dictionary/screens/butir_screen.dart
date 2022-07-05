import 'package:buku_saku_2/configs/components.dart';
import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/blue_card_button.dart';
import 'package:buku_saku_2/screens/app/dictionary/screens/butir_detail_screen.dart';

class ButirScreen extends StatelessWidget {
  const ButirScreen(
      {Key? key,
      required this.butirList,
      this.unsurCode,
      this.unsurTitle,
      this.subUnsurCode,
      this.subUnsurTitle})
      : super(key: key);
  final List<ButirKegiatan> butirList;
  final String? unsurCode;
  final String? unsurTitle;
  final String? subUnsurCode;
  final String? subUnsurTitle;

  @override
  Widget build(BuildContext context) {
    if (butirList.isEmpty) {
      return const Center(child: Text('Tidak ada butir yang cocok'));
    } else {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        itemCount: butirList.length,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          String? subtitle;
          (butirList[index].persenAK == null)
              ? subtitle =
                  AppComponents.convertNumberToId(butirList[index].angkaKredit)
              : subtitle =
                  (butirList[index].persenAK! * 100).toInt().toString() +
                      '% AK Naik Pangkat';
          return BlueCardButton(
            code: butirList[index].kode,
            title: butirList[index].judul,
            subtitle: "Angka Kredit: " + subtitle,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ButirDetailScreen(
                    butir: butirList[index],
                    unsurCode: unsurCode,
                    unsurTitle: unsurTitle,
                    subUnsurCode: subUnsurCode,
                    subUnsurTitle: subUnsurTitle,
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }
}
