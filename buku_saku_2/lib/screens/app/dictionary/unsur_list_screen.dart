import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/blue_card_button.dart';
import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/components/searchbox.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/dictionary/sub_unsur_list_screen.dart';
import 'package:buku_saku_2/screens/app/models/screen_provider.dart';
import 'package:provider/provider.dart';

class UnsurListScreen extends StatefulWidget {
  static const id = 'unsur_list_screen';
  final AnimationController? animationController;
  const UnsurListScreen({Key? key, this.animationController}) : super(key: key);

  @override
  _UnsurListScreenState createState() => _UnsurListScreenState();
}

class _UnsurListScreenState extends State<UnsurListScreen> {
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
    return Container(
      color: AppColors.offWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            const AppBarUI(title: 'Kamus'),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return ListView(
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      scrollDirection: Axis.vertical,
      children: [
        const SearchBox(),
        FutureBuilder(
          future: readJsonData(),
          builder: (context, AsyncSnapshot<List<ButirKegiatan>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('ERROR!! ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                itemCount: snapshot.data!.length,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  getData(snapshot.data);
                  return BlueCardButton(
                    code: codes![index],
                    title: titles![index],
                    subtitle: subtitles![index],
                    onPressed: () {
                      context.read<ScreenProvider>().setUnsurCode =
                          codes![index];
                      context.read<ScreenProvider>().setUnsur = titles![index];
                      context.read<ScreenProvider>().setTabBody =
                          SubUnsurListScreen(subUnsur: subUnsur![index]);
                    },
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
