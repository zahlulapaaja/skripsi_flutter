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
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Stack;

class ExportNotesScreen extends StatefulWidget {
  static const id = 'export_notes_screen';
  const ExportNotesScreen({Key? key}) : super(key: key);

  @override
  State<ExportNotesScreen> createState() => _ExportNotesScreenState();
}

class _ExportNotesScreenState extends State<ExportNotesScreen> {
  // nanti ganti jadi stateless bisa ga ini, soalnya screennya sederhana
  var dbHelper = DbHelper();
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

  Future<DocFile> createExcel() async {
    // membuat file excel
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    // input title ke row pertama
    sheet.importList(title, 1, 1, false);

    // input data dari database
    List<Note> notes = await dbHelper.getNotes();
    for (int i = 0; i < notes.length; i++) {
      // +2 karna ga ada baris 0, dan baris satu udh diisi title
      sheet.importList(notes[i].toList(), i + 2, 1, false);
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    // memanggil path dan menyimpan file
    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName =
        DateFormat("yyyy-MM-dd HH:mm:ss", "id_ID").format(DateTime.now()) +
            ' - Ekspor Catatan.xlsx';
    final File file = File('$path/$fileName');
    final newFile = await file.writeAsBytes(bytes, flush: true);

    return DocFile(
      path: newFile.path,
      name: fileName.split('.')[0],
      extension: ".xlsx",
      dateCreated: DateTime.now(),
    );
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
  }

  Widget getMainListViewUI() {
    return Container(
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: ElevatedButton(
                onPressed: () async {
                  DocFile docFile = await createExcel();
                  context.read<NotesProvider>().exportNotes(docFile);
                  OpenFile.open(docFile.path);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColors.primaryLight),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: const Text("Ekspor Catatan"),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: context.watch<NotesProvider>().excelFiles,
                builder: (context, AsyncSnapshot<List<DocFile>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('error fetching data, ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<DocFile> files = snapshot.data!;
                    if (files.isEmpty)
                      return const Text("Belum ada data ekspor");
                    return ListView.builder(
                      itemCount: files.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(files[index].name),
                          subtitle: Text(DateFormat("dd MMM yyyy", "id_ID")
                              .format(files[index].dateCreated!)),
                          leading: Image.asset("assets/icons/excel_file.png"),
                          trailing: IconButton(
                            onPressed: () async {
                              // kasih alert dulu
                              File(files[index].path).delete();
                              context
                                  .read<NotesProvider>()
                                  .deleteExcelFiles(files[index].id!);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: AppColors.alert,
                            ),
                          ),
                          onTap: () {
                            OpenFile.open(files[index].path);
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }
}
