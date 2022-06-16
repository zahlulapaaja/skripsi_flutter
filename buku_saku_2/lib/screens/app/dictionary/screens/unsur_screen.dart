import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/blue_card_button.dart';
import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/dictionary/screens/sub_unsur_screen.dart';
import 'package:buku_saku_2/screens/app/models/providers/dictionary_provider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UnsurScreen extends StatelessWidget {
  // Nanti ini perbaiki lagi, apakah cocok pake string ??
  const UnsurScreen({Key? key}) : super(key: key);

  Future<List<Unsur>> readJsonData(String jenjang) async {
    const jsonPrakomAhli = 'assets/jsonfile/data_juknis_ahli.json';
    const jsonPrakomTerampil = 'assets/jsonfile/data_juknis_terampil.json';
    const jsonTambahan = 'assets/jsonfile/data_juknis_tambahan.json';
    dynamic jsonData;

    if (jenjang.contains('ahli')) {
      jsonData = await rootBundle.loadString(jsonPrakomAhli);
    } else {
      jsonData = await rootBundle.loadString(jsonPrakomTerampil);
    }

    final jsonDataAddition = await rootBundle.loadString(jsonTambahan);

    List<dynamic> list = json.decode(jsonData) as List<dynamic>;
    list += json.decode(jsonDataAddition) as List<dynamic>;

    return list.map((e) => Unsur.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    String jenjang = context.read<DictionaryProvider>().selectedJenjang;
    return FutureBuilder(
        future: readJsonData(jenjang),
        builder: (context, AsyncSnapshot<List<Unsur>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('ERROR!! ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Unsur> unsur = snapshot.data!;
            context.read<DictionaryProvider>().storeData = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              itemCount: unsur.length,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return BlueCardButton(
                  code: unsur[index].code!,
                  title: unsur[index].title!,
                  subtitle: unsur[index].subtitle!,
                  onPressed: () {
                    context.read<DictionaryProvider>().setDictionaryList =
                        SubUnsurScreen(unsur: unsur[index]);
                  },
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
