import 'package:buku_saku_2/screens/app/models/screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/blue_card_button.dart';
import 'package:buku_saku_2/screens/app/components/searchbox.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/dictionary/butir_detail_screen.dart';
import 'package:provider/provider.dart';

class ButirListScreen extends StatelessWidget {
  ButirListScreen({Key? key, required this.butir}) : super(key: key);

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
        SearchBox(),
        ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          itemCount: butir.length,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            getData(butir);
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
        ),
      ],
    );
  }
}
