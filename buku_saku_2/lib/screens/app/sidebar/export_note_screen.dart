import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/components.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/models/db/database.dart';
import 'package:buku_saku_2/screens/app/models/doc_file.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExportNotesScreen extends StatefulWidget {
  static const id = 'export_notes_screen';
  const ExportNotesScreen({Key? key}) : super(key: key);

  @override
  State<ExportNotesScreen> createState() => _ExportNotesScreenState();
}

class _ExportNotesScreenState extends State<ExportNotesScreen> {
  var dbHelper = DbHelper();

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
                  String? result = await showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Ekspor Catatan'),
                      content:
                          const Text('Lanjutkan mengekspor catatan Anda ?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Tidak'),
                          child: const Text('Tidak'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Ya'),
                          child: const Text('Ya'),
                        ),
                      ],
                    ),
                  );
                  if (result == "Ya") {
                    List<Note> notes = await dbHelper.exportNotes();
                    if (notes.isNotEmpty) {
                      AppComponents.toastAlert(
                        msg: "Catatan masih kosong !!",
                        color: AppColors.alert,
                      );
                    } else {
                      DocFile docFile = await Note.createExcel(notes);
                      context.read<NotesProvider>().exportNotes(docFile);
                      // await dbHelper.saveExportNote(docFile);
                      docFile.openFile();
                    }
                  }
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
                        child: Text('Error fetching data: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<DocFile> files = snapshot.data!;
                    if (files.isEmpty) {
                      return const Text("Belum ada data ekspor catatan");
                    }
                    return ListView.builder(
                      itemCount: files.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(files[index].getName),
                          subtitle: Text(files[index].getDateCreated),
                          leading: Image.asset("assets/icons/excel_file.png"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // IconButton(
                              //   onPressed: () {
                              //     files[index].shareFile();
                              //   },
                              //   icon: const Icon(
                              //     Icons.share_rounded,
                              //     color: AppColors.black,
                              //   ),
                              // ),
                              IconButton(
                                onPressed: () async {
                                  String? result = await showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Hapus File Ekspor'),
                                      content: const Text(
                                          'Anda yakin ingin menghapus file ekspor ini ?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Tidak'),
                                          child: const Text('Tidak'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Ya'),
                                          child: const Text('Ya'),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (result == 'Ya') {
                                    files[index].deleteFile();
                                    context
                                        .read<NotesProvider>()
                                        .deleteExcelFiles(files[index].getId);
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColors.alert,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            files[index].openFile();
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
