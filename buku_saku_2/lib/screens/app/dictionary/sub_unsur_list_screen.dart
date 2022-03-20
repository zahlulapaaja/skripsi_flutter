import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/dictionary/butir_list_screen.dart';
import 'package:buku_saku_2/screens/app/models/screen_provider.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/blue_card_button.dart';
import 'package:buku_saku_2/screens/app/components/searchbox.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SubUnsurListScreen extends StatelessWidget {
  final List<dynamic> subUnsur;
  SubUnsurListScreen({Key? key, required this.subUnsur}) : super(key: key);

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
    return Container(
      color: AppColors.offWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(context),
            const AppBarUI(title: 'Kamus'),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      scrollDirection: Axis.vertical,
      children: [
        const SearchBox(),
        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          itemCount: subUnsur.length,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            getData(subUnsur);
            return BlueCardButton(
              code: codes![index],
              title: titles![index],
              subtitle: subtitles![index],
              onPressed: () {
                context.read<ScreenProvider>().setSubUnsurCode = codes![index];
                context.read<ScreenProvider>().setSubUnsur = titles![index];
                context.read<ScreenProvider>().setTabBody =
                    ButirListScreen(butir: subUnsur[index]['butir']);
              },
            );
          },
        ),
      ],
    );
  }
}
