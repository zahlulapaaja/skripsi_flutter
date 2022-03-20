import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/blue_grid_container.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/blue_container.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/detail_butir.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/notes/add_note_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButirDetailScreen extends StatelessWidget {
  ButirDetailScreen({Key? key, required this.detailButir}) : super(key: key);

  final Map<String, dynamic> detailButir;
  final List<Widget> listViews = <Widget>[];

  void addAllListData() {
    listViews.add(
      const SizedBox(height: 20),
    );

    listViews.add(
      DetailButir(
        butirCode: detailButir['kode'],
        butirTitle: detailButir['judul'],
      ),
    );
    listViews.add(
      BlueContainer(
        title: 'Deskripsi Kegiatan',
        body: detailButir['uraian'],
      ),
    );

    listViews.add(
      BlueGridContainer(
        satuanHasil: detailButir['satuan_hasil'],
        angkaKredit: detailButir['angka_kredit'],
        batasanPenilaian: detailButir['batasan_penilaian'],
        pelaksana: detailButir['pelaksana'],
      ),
    );

    listViews.add(
      BlueContainer(
        title: 'Bukti Fisik',
        body: detailButir['bukti_fisik'],
      ),
    );
    listViews.add(
      BlueContainer(
        title: 'Contoh',
        body: detailButir['contoh'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.offWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          heroTag: 'button2tag',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AddNoteScreen(butirCode: detailButir['kode']),
              ),
            );
          },
          backgroundColor: AppColors.primary,
          child: const Icon(FontAwesomeIcons.plus),
        ),
        body: Stack(
          children: <Widget>[
            getMainListViewUI(context),
            AppBarUI(
              title: 'Detail Butir',
              backButton: true,
              backButtonCallback: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI(BuildContext context) {
    addAllListData();

    return ListView.builder(
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: listViews.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return listViews[index];
      },
    );
  }
}
