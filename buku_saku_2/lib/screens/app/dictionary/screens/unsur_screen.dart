import 'package:flutter/material.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/blue_card_button.dart';
import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/dictionary/screens/sub_unsur_screen.dart';
import 'package:buku_saku_2/screens/app/models/dictionary_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UnsurScreen extends StatelessWidget {
  static const id = 'unsur_screen';
  UnsurScreen({Key? key}) : super(key: key);

  List<String>? codes;
  List<String>? titles;
  List<String>? subtitles;
  List<dynamic>? subUnsur;

  void getData(List<ButirKegiatan> data) {
    codes = List<String>.generate(
        data.length, (index) => data[index].code.toString(),
        growable: true);

    titles = List<String>.generate(
        data.length, (index) => data[index].title.toString(),
        growable: true);

    subtitles = List<String>.generate(data.length,
        (index) => data[index].subunsur!.length.toString() + " Sub Unsur",
        growable: true);

    subUnsur = List<dynamic>.generate(
        data.length, (index) => data[index].subunsur,
        growable: true);
  }

  @override
  Widget build(BuildContext context) {
    List<ButirKegiatan> data = context.read<DictionaryProvider>().jsonData;
    getData(data);
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      itemCount: data.length,
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return BlueCardButton(
          code: codes![index],
          title: titles![index],
          subtitle: subtitles![index],
          onPressed: () {
            context.read<DictionaryProvider>().setUnsurCode = codes![index];
            context.read<DictionaryProvider>().setUnsur = titles![index];
            context.read<DictionaryProvider>().setDictionaryList =
                SubUnsurScreen(subUnsur: subUnsur![index]);
          },
        );
      },
    );
  }
}
