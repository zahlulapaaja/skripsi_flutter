import 'package:flutter/material.dart';
import 'package:buku_saku_2/screens/app/dictionary/screens/butir_screen.dart';
import 'package:buku_saku_2/screens/app/models/dictionary_provider.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/blue_card_button.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SubUnsurScreen extends StatelessWidget {
  final List<dynamic> subUnsur;
  SubUnsurScreen({Key? key, required this.subUnsur}) : super(key: key);

  List<String>? codes;
  List<String>? titles;
  List<String>? subtitles;
  List<dynamic>? butir;

  void getData(dynamic data) {
    codes = List<String>.generate(
        data.length, (index) => data[index]['kode'].toString(),
        growable: true);

    titles = List<String>.generate(
        data.length, (index) => data[index]['judul'].toString(),
        growable: true);

    subtitles = List<String>.generate(data.length,
        (index) => data[index]['butir'].length.toString() + " Butir Kegiatan",
        growable: true);

    butir = List<dynamic>.generate(data.length, (index) => data[index]['butir'],
        growable: true);
  }

  @override
  Widget build(BuildContext context) {
    getData(subUnsur);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      itemCount: subUnsur.length,
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return BlueCardButton(
          code: codes![index],
          title: titles![index],
          subtitle: subtitles![index],
          onPressed: () {
            context.read<DictionaryProvider>().setSubUnsurCode = codes![index];
            context.read<DictionaryProvider>().setSubUnsur = titles![index];
            context.read<DictionaryProvider>().setDictionaryList =
                ButirScreen(butir: subUnsur[index]['butir']);
          },
        );
      },
    );
  }
}
