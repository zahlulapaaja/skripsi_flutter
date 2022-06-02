import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/blue_card_button.dart';
import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/dictionary/screens/sub_unsur_screen.dart';
import 'package:buku_saku_2/screens/app/models/dictionary_provider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UnsurScreen extends StatelessWidget {
  // Nanti ini perbaiki lagi, apakah cocok pake string ??
  final String jenjang;
  const UnsurScreen({Key? key, required this.jenjang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<DictionaryProvider>().setJenjang = jenjang;
    return FutureBuilder(
        future: context.read<DictionaryProvider>().readJsonData,
        builder: (context, AsyncSnapshot<List<Unsur>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('ERROR!! ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // TODO : Nanti disini klo datanya kosong, kondisikan lagi tampilannya

            List<Unsur> unsur = context.read<DictionaryProvider>().jsonData;
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
