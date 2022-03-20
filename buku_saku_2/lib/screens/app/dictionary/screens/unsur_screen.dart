import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/blue_card_button.dart';
import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/dictionary/screens/sub_unsur_screen.dart';
import 'package:buku_saku_2/screens/app/models/dictionary_provider.dart';
import 'package:provider/provider.dart';

class UnsurScreen extends StatefulWidget {
  static const id = 'unsur_screen';
  const UnsurScreen({Key? key}) : super(key: key);

  @override
  _UnsurScreenState createState() => _UnsurScreenState();
}

class _UnsurScreenState extends State<UnsurScreen> {
  List<String>? codes;
  List<String>? titles;
  List<String>? subtitles;
  List<dynamic>? subUnsur;

  Future<List<ButirKegiatan>> readJsonData() async {
    final jsonData =
        await rootBundle.loadString('assets/jsonfile/data_juknis_trial.json');
    final list = json.decode(jsonData) as List<dynamic>;

    return list.map((e) => ButirKegiatan.fromJson(e)).toList();
  }

  List<Map<String, dynamic>> storeData(List<dynamic> data) {
    List<Map<String, dynamic>> butirList = [];
    for (var i = 0; i < data.length; i++) {
      for (var j = 0; j < data[i].subunsur.length; j++) {
        for (var k = 0; k < data[i].subunsur[j]['butir'].length; k++) {
          Map<String, dynamic> butir = data[i].subunsur[j]['butir'][k];
          butirList.add(butir);
        }
      }
    }
    return butirList;
  }

  void getData(dynamic data) {
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
    return FutureBuilder(
      future: readJsonData(),
      builder: (context, AsyncSnapshot<List<ButirKegiatan>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('ERROR!! ${snapshot.error}'));
        } else if (snapshot.hasData) {
          context.read<DictionaryProvider>().setAllButir =
              storeData(snapshot.data!);
          getData(snapshot.data);

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            itemCount: snapshot.data!.length,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return BlueCardButton(
                code: codes![index],
                title: titles![index],
                subtitle: subtitles![index],
                onPressed: () {
                  context.read<DictionaryProvider>().setUnsurCode =
                      codes![index];
                  context.read<DictionaryProvider>().setUnsur = titles![index];
                  context.read<DictionaryProvider>().setDictionaryList =
                      SubUnsurScreen(subUnsur: subUnsur![index]);
                },
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
