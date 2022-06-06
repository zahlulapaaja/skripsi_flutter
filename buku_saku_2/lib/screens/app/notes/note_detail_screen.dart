import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/models/db/database.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/notes/add_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';

class NoteDetailScreen extends StatefulWidget {
  NoteDetailScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  var dbHelper = DbHelper();

  Future<Note> getData(int id) async {
    var result = await dbHelper.getNoteById(id);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dbHelper.getNoteById(widget.id),
      builder: (context, AsyncSnapshot<Note> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('error fetching data, ${snapshot.error}'));
        } else if (snapshot.hasData) {
          Note note = snapshot.data!;
          return Container(
            color: AppColors.offWhite,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  final value = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNoteScreen(note: note),
                    ),
                  );
                  setState(() {
                    if (value != null) {
                      print('welkam bek 2');
                    } else {
                      print('print');
                    }
                  });
                  if (value != null) {
                    print('welkam bek 2');
                  } else {
                    print('print');
                  }
                },
              ),
              body: Stack(
                children: <Widget>[
                  ListView(
                    padding: EdgeInsets.only(
                      top: AppBar().preferredSize.height +
                          MediaQuery.of(context).padding.top,
                      bottom: 62 + MediaQuery.of(context).padding.bottom,
                    ),
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Text('id: ${note.id}', textAlign: TextAlign.center),
                          Text('judul: ${note.judul}',
                              textAlign: TextAlign.center),
                          Text('uraian: ${note.uraian}',
                              textAlign: TextAlign.center),
                          Text(
                              'tanggal kegiatan: ${note.listTanggal.toString()}',
                              textAlign: TextAlign.center),
                          Text('kode butir: ${note.kodeButir}',
                              textAlign: TextAlign.center),
                          Text('tanggal: ${note.listTanggal}',
                              textAlign: TextAlign.center),
                          (note.buktiFisik != null)
                              ? GridView.builder(
                                  padding: const EdgeInsets.only(top: 10),
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                  ),
                                  itemCount: note.buktiFisik!.length,
                                  physics: const ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: <Widget>[
                                        Expanded(
                                          child: Card(
                                            child: InkWell(
                                              onTap: () {
                                                openFile(note
                                                    .buktiFisik![index].path);
                                              },
                                              child: Center(
                                                  child: Text(
                                                      '${note.buktiFisik![index].namaFile}.${note.buktiFisik![index].extension}')),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '${note.buktiFisik![index].namaFile}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    );
                                  },
                                )
                              : const Center(child: Text('bukti belum ada')),
                          // Text('bukti: ${note.buktiFisik![0].path}',
                          //     textAlign: TextAlign.center),
                        ],
                      ),
                    ],
                  ),
                  AppBarUI(
                    title: '',
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
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void openFile(String path) {
    OpenFile.open(path);
  }
}
