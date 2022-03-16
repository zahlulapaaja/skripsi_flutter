import 'dart:convert';

import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/components/card_builder.dart';
import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class MenuUnsur extends StatefulWidget {
  MenuUnsur({Key? key}) : super(key: key);

  @override
  State<MenuUnsur> createState() => _MenuUnsurState();
}

class _MenuUnsurState extends State<MenuUnsur> {
  // final List<ButirKegiatan> items;
  List<String>? codes;
  List<String>? titles;
  List<String>? subtitles;
  int? selectedIndex = null;
  bool unsurScreen = true;

  String? unsur;

  getData(items) {
    if (unsurScreen) {
      codes = List<String>.generate(
          items.length, (index) => items[index].code.toString(),
          growable: true);

      titles = List<String>.generate(
          items.length, (index) => items[index].title.toString(),
          growable: true);

      subtitles = List<String>.generate(
          items.length, (index) => items[index].subunsur.length.toString(),
          growable: true);
    } else {
      codes = List<String>.generate(items[0].subunsur.length,
          (index) => items[0].subunsur[index]['kode'].toString(),
          growable: true);

      titles = List<String>.generate(items[0].subunsur.length,
          (index) => items[0].subunsur[index]['judul'].toString(),
          growable: true);

      subtitles = List<String>.generate(items[0].subunsur.length,
          (index) => items[0].subunsur[index]['butir'].length.toString(),
          growable: true);
    }
  }

  // Liat dulu : Baca filenya di file sebelumnya aja, nanti disini tinggal ngirim datanya aja
  Future<List<ButirKegiatan>> ReadJsonData() async {
    final jsonData =
        await rootBundle.loadString('assets/jsonfile/data_juknis_trial.json');
    final list = json.decode(jsonData) as List<dynamic>;

    return list.map((e) => ButirKegiatan.listUnsur(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            // print(data.runtimeType);
            print(data.error);
            return Center(
                child: Text(
              '${data.error}',
              style: TextStyle(fontSize: 24),
            ));
          } else if (data.hasData) {
            // print(data.runtimeType);
            var items = data.data as List<ButirKegiatan>;
            // print(items.runtimeType);
            getData(items);

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              itemCount: unsurScreen ? items.length : items[0].subunsur!.length,
              physics: const ScrollPhysics(),
              // to enable GridView's scrolling
              shrinkWrap: true,
              // You won't see infinite size error
              itemBuilder: (context, index) {
                String title = titles![index];
                String code = codes![index];
                String subtitle = subtitles![index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        unsurScreen = !unsurScreen;
                        // print(items.runtimeType);
                        // getdata(items);
                      });
                    },
                    style: AppConstants.kDictBtnStyle,
                    child: Container(
                      height: 80,
                      child: Row(
                        children: [
                          Container(
                            width: 75,
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              code,
                              textAlign: TextAlign.left,
                              style: AppConstants.kLargeTitleTextStyle,
                            ),
                          ),
                          // SizedBox(width: 50, child: Text('data')),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppConstants.kCardTitleTextStyle,
                                ),
                                Text(
                                  '($subtitle Sub Unsur)',
                                  textAlign: TextAlign.left,
                                  style: AppConstants.kCardBodyTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
