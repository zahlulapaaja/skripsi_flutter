import 'package:buku_saku_2/configs/components.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/blue_container.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/ringkasan_butir.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/notes/add_note_screen.dart';
import 'package:provider/provider.dart';

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
      RingkasanButir(
        code: butir.kode,
        jenjang: butir.pelaksana,
        angkaKredit: butir.angkaKredit,
        persenAK: butir.persenAK,
      ),
    );

    listViews.add(
      BlueContainer(
        title: 'Rincian Butir',
        body: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 75,
                  child: Text(
                    unsurCode ?? butir.unsurCode!,
                    textAlign: TextAlign.left,
                    style: AppConstants.kDictionaryTextStyle(),
                  ),
                ),
                Expanded(
                  child: Text(
                    unsurTitle ?? butir.unsurTitle!.toUpperCase(),
                    style: AppConstants.kDictionaryTextStyle(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 75,
                  child: Text(
                    subUnsurCode ?? butir.subUnsurCode!,
                    textAlign: TextAlign.left,
                    style: AppConstants.kDictionaryTextStyle(),
                  ),
                ),
                Expanded(
                  child: Text(
                    subUnsurTitle ?? butir.subUnsurTitle!,
                    style: AppConstants.kDictionaryTextStyle(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 75,
                  child: Text(
                    butir.kode,
                    textAlign: TextAlign.left,
                    style: AppConstants.kDictionaryTextStyle(
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Expanded(
                  child: Text(
                    butir.judul,
                    style: AppConstants.kDictionaryTextStyle(
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    listViews.add(
      BlueContainer(
        title: 'Deskripsi Kegiatan',
        body: (butir.uraian == "")
            ? Text(
                "-",
                textAlign: TextAlign.justify,
                style: AppConstants.kDictionaryTextStyle(),
              )
            : getTidyText(butir.uraian),
      ),
    );

    listViews.add(
      BlueContainer(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Satuan Hasil',
                  style: AppConstants.kDictionaryTextStyle(
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  butir.satuanHasil,
                  style: AppConstants.kDictionaryTextStyle(),
                ),
                const SizedBox(height: 12),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Angka Kredit',
                  style: AppConstants.kDictionaryTextStyle(
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  (butir.persenAK == null)
                      ? AppComponents.convertNumberToId(butir.angkaKredit)
                      : AppComponents.convertNumberToId(butir.angkaKredit) +
                          ' (' +
                          (butir.persenAK! * 100).toInt().toString() +
                          '% Angka Kredit Kenaikan Pangkat)',
                  style: AppConstants.kDictionaryTextStyle(),
                ),
                const SizedBox(height: 12),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Batasan Penilaian',
                  style: AppConstants.kDictionaryTextStyle(
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                (!butir.batasanPenilaian.contains('1.'))
                    ? Text(
                        butir.batasanPenilaian == ""
                            ? "-"
                            : butir.batasanPenilaian,
                        textAlign: TextAlign.justify,
                        style: AppConstants.kDictionaryTextStyle(),
                      )
                    : getTidyText(butir.batasanPenilaian),
                const SizedBox(height: 12),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Pelaksana',
                  style: AppConstants.kDictionaryTextStyle(
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  butir.pelaksana,
                  style: AppConstants.kDictionaryTextStyle(),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ],
        ),
      ),
    );

    listViews.add(
      BlueContainer(
        title: 'Bukti Fisik',
        body: (!butir.buktiFisik.contains('1.'))
            ? Text(
                butir.buktiFisik,
                textAlign: TextAlign.justify,
                style: AppConstants.kDictionaryTextStyle(),
              )
            : getTidyText(butir.buktiFisik),
      ),
    );
    listViews.add(
      BlueContainer(
        title: 'Contoh',
        body: Text(
          butir.contoh.split('\n').join('\n\n'),
          textAlign: TextAlign.justify,
          style: AppConstants.kDictionaryTextStyle(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Jenjang> listJenjang = context.read<ProfileProvider>().listJenjang;
    Jenjang jenjang = context.read<ProfileProvider>().profil.jenjang!;

    return Container(
      color: AppColors.offWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          heroTag: 'button2tag',
          onPressed: () async {
            bool exist = await butir.isExist;

            int? kodeJenjang;
            for (var item in listJenjang) {
              if (item.jenjang == butir.pelaksana) {
                kodeJenjang = item.kodeJenjang;
              }
            }

            if (butir.pelaksana == "Semua Jenjang" ||
                (kodeJenjang! - jenjang.kodeJenjang).abs() < 2) {
              exist
                  ? AppComponents.toastAlert(
                      msg: "Catatan sudah ada",
                      color: AppColors.alert,
                    )
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNoteScreen(butir: butir),
                      ),
                    );
            } else {
              AppComponents.toastAlert(
                msg: "Butir ini tidak sesuai dengan jenjang Anda",
                color: AppColors.alert,
              );
            }
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add),
        ),
        body: Stack(
          children: <Widget>[
            getMainListViewUI(context),
            AppBarUI(
              title: 'Detail Butir',
              leftIconButton: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  color: AppColors.offWhite,
                  size: AppConstants.kHugeFontSize,
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

  Widget getTidyText(String input) {
    List<String> textList = input.split('\n');
    List<Widget> widgetList = [];

    for (String text in textList) {
      if (text.substring(1, 3).contains('.')) {
        final int dot = text.indexOf('.');
        final String numbering = text.substring(0, dot);
        final String value = text.substring(dot + 1);
        widgetList.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (RegExp(r'^[0-9]+$').hasMatch(numbering))
                    ? '$numbering.  '
                    : '     $numbering.  ',
                textAlign: TextAlign.justify,
                style: AppConstants.kDictionaryTextStyle(),
              ),
              Expanded(
                child: Text(
                  value.trimLeft(),
                  textAlign: TextAlign.justify,
                  style: AppConstants.kDictionaryTextStyle(),
                ),
              ),
            ],
          ),
        );
      } else {
        widgetList.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              '     ' + text,
              textAlign: TextAlign.justify,
              style: AppConstants.kDictionaryTextStyle(),
            ),
          ),
        );
      }
    }
    widgetList.add(const SizedBox(height: 8));

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widgetList,
    );
  }
}
