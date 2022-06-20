import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:open_file/open_file.dart';

class DasarPeraturanScreen extends StatelessWidget {
  static const id = 'dasar_peraturan_screen';
  const DasarPeraturanScreen({Key? key}) : super(key: key);
  static const List<Map<String, dynamic>> listFile = [
    {
      "name":
          "PermenPANRB No32 Tahun 2020 Tentang Jabatan Fungsional Pranata Komputer",
      "fileName": "PermenPAN_No_32_Tahun_2020_Tentang_JFT_Prakom.pdf",
      "extension": "pdf",
    },
    {
      "name":
          "Petunjuk Teknis Penilaian Angka Kredit Jabatan Fungsional Pranata Komputer",
      "fileName": "Petunjuk_Teknis_Penilaian_Angka_Kredit_JFT_Prakom.pdf",
      "extension": "pdf",
    },
    {
      "name": "Tunjangan Jatabtan Fungsional Pranata Komputer",
      "fileName": "Tunjangan_JFT_Prakom.pdf",
      "extension": "pdf",
    },
    // "file juknis 2",
    // "file juknis 3",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.offWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(context),
            AppBarUI(
              title: 'Dasar peraturan',
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

  Widget getMainListViewUI(context) {
    return Container(
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
      ),
      child: ListView.builder(
        itemCount: listFile.length,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listFile[index]["name"]),
            leading: SizedBox(
              width: 60,
              child: Card(
                  color: AppColors.beigeDark,
                  child: Center(
                    child: Text(listFile[index]['extension']),
                  )),
            ),
            onTap: () {
              // OpenFile.open("/assets/files/${listFile[index]["fileName"]}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFViewer(
                      assetPath: "assets/files/${listFile[index]['fileName']}"),
                ),
              );
              // OpenFile.open();
            },
          );
        },
      ),
    );
  }
}

class PDFViewer extends StatelessWidget {
  const PDFViewer({Key? key, required this.assetPath}) : super(key: key);
// final pdfController;
  final String assetPath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: PdfViewPinch(
        controller: PdfControllerPinch(
          document: PdfDocument.openAsset(
              'assets/files/PermenPAN_No_32_Tahun_2020_Tentang_JFT_Prakom.pdf'),
        ),
      )),
    );
  }
}
