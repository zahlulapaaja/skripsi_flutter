import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/models/db/database.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Stack;

class ExportNotesScreen extends StatelessWidget {
  static const id = 'export_notes_screen';

  // nanti ganti jadi stateless bisa ga ini, soalnya screennya sederhana
  var dbHelper = DbHelper();
  final List<Widget> listViews = <Widget>[];

  Future<DocFile> createExcel() async {
    const bool isVertical = false;

    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    final List<Object> title = [
      "id",
      "judul",
      "uraian",
      "kode_butir",
      "jumlah_kegiatan",
      "angka_kredit",
      "kegiatan_tim",
      "jumlah_anggota",
      "peran_dalam_tim",
      "list_tanggal",
      "status",
      "date_created",
    ];
    sheet.importList(title, 1, 1, isVertical);

    List<Note> notes = await dbHelper.getNotes();
    for (int i = 0; i < notes.length; i++) {
      // karna ga ada baris 0, dan baris satu udh diisi judul
      sheet.importList(notes[i].toList(), i + 2, 1, isVertical);
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = "Ekspor Catatan " +
        DateFormat("yyyy-MM-dd HH:mm:ss", "id_ID").format(DateTime.now()) +
        '.xlsx';

    final File file = File('$path/$fileName');
    final newFile = await file.writeAsBytes(bytes, flush: true);

    return DocFile(
      path: newFile.path,
      namaFile: fileName.split('.')[0],
      extension: ".xlsx",
      dateCreated: DateTime.now(),
    );
  }

  void addAllListData(context) {
    listViews.add(
      const SizedBox(height: 20),
    );

    listViews.add(
      Center(
        child: ElevatedButton(
          onPressed: () async {
            DocFile docFile = await createExcel();
            await dbHelper.saveExportNote(docFile);
            OpenFile.open(docFile.path);
          },
          child: const Text("Ekspor"),
        ),
      ),
    );

    listViews.add(
      Center(child: Text("text2")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dbHelper.getExportNote(),
      builder: (context, AsyncSnapshot<List<DocFile>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('error fetching data, ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<DocFile> files = snapshot.data!;
          print(files);
          return Container(
            color: AppColors.offWhite,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: <Widget>[
                  getMainListViewUI(context),
                  AppBarUI(
                    title: 'Ekspor Catatan',
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
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget getMainListViewUI(BuildContext context) {
    addAllListData(context);

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
