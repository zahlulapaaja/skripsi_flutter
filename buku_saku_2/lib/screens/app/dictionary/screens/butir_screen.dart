import 'package:flutter/material.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/blue_card_button.dart';
import 'package:buku_saku_2/screens/app/dictionary/screens/butir_detail_screen.dart';

// ignore: must_be_immutable
class ButirScreen extends StatelessWidget {
  ButirScreen({Key? key, required this.butir}) : super(key: key);

  final List<dynamic> butir;
  List<String>? codes;
  List<String>? titles;
  List<String>? subtitles;
  List<dynamic>? detailButir;

  void getData(dynamic data) {
    codes = List<String>.generate(
        data.length, (index) => data[index]['kode'].toString(),
        growable: true);

    titles = List<String>.generate(
        data.length, (index) => data[index]['judul'].toString(),
        growable: true);

    subtitles = List<String>.generate(data.length,
        (index) => "Angka Kredit : " + data[index]['angka_kredit'].toString(),
        growable: true);

    detailButir = List<dynamic>.generate(data.length, (index) => data[index],
        growable: true);
  }

  @override
  Widget build(BuildContext context) {
    if (butir.isEmpty) {
      return const Center(child: Text('Data tidak ditemukan'));
    } else {
      getData(butir);

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        itemCount: butir.length,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return BlueCardButton(
            code: codes![index],
            title: titles![index],
            subtitle: subtitles![index],
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ButirDetailScreen(
                    detailButir: detailButir![index],
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
