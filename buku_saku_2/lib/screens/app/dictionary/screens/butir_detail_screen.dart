import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/blue_grid_container.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/blue_container.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/detail_butir.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/notes/add_note_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ButirDetailScreen extends StatelessWidget {
  ButirDetailScreen(
      {Key? key,
      required this.butir,
      this.unsurCode,
      this.unsurTitle,
      this.subUnsurCode,
      this.subUnsurTitle})
      : super(key: key);

  final ButirKegiatan butir;
  final String? unsurCode;
  final String? unsurTitle;
  final String? subUnsurCode;
  final String? subUnsurTitle;

  final List<Widget> listViews = <Widget>[];

  void addAllListData() {
    listViews.add(
      const SizedBox(height: 20),
    );

    listViews.add(
      DetailButir(
        butir: butir,
        unsurCode: unsurCode,
        unsurTitle: unsurTitle,
        subUnsurCode: subUnsurCode,
        subUnsurTitle: subUnsurTitle,
      ),
    );
    listViews.add(
      BlueContainer(
        title: 'Deskripsi Kegiatan',
        body: butir.uraian,
      ),
    );

    listViews.add(
      BlueGridContainer(
        satuanHasil: butir.satuanHasil,
        angkaKredit: butir.angkaKredit,
        batasanPenilaian: butir.batasanPenilaian,
        pelaksana: butir.pelaksana,
      ),
    );

    listViews.add(
      BlueContainer(
        title: 'Bukti Fisik',
        body: butir.buktiFisik,
      ),
    );
    listViews.add(
      BlueContainer(
        title: 'Contoh',
        body: butir.contoh,
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
                builder: (context) => AddNoteScreen(butirCode: butir.kode),
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
              leftIconButton: IconButton(
                icon: const Icon(
                  FontAwesomeIcons.chevronLeft,
                  color: AppColors.offWhite,
                  size: AppConstants.kLargeFontSize,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
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
