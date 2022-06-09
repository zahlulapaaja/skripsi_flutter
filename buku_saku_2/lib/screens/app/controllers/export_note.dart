import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/models/db/database.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
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

  Future<void> createExcel() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText("Hello WorldR");
    // disini panggil db dan bikin settext nya
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Output.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dbHelper.getNotes(),
      builder: (context, AsyncSnapshot<List<Note>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('error fetching data, ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<Note> notes = snapshot.data!;
          return Container(
            color: AppColors.offWhite,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: <Widget>[
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            print("Halooo");
                            // exportToExcel();
                            createExcel();
                          },
                          child: Text("halo"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            print("Halooo");
                            // readExcel();
                          },
                          child: Text("open"),
                        ),
                        // FutureBuilder(
                        //     future: readExcel(),
                        //     builder: (context, snapshot) {
                        //       return ElevatedButton(
                        //         onPressed: () {
                        //           print(snapshot.hasData);
                        //           print("berhasil");
                        //           // readExcel();
                        //         },
                        //         child: Text("open"),
                        //       );
                        //     }),
                      ],
                    ),
                  ),
                  AppBarUI(
                    title: 'Detail Catatan',
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
                    rightIconButton: IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.edit,
                        color: AppColors.offWhite,
                        size: AppConstants.kLargeFontSize,
                      ),
                      onPressed: () async {
                        // final value = await Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => AddNoteScreen(note: note),
                        //   ),
                        // );
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
}
