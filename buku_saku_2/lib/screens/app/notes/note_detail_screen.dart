import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/models/db/database.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/notes/add_note_screen.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/date_picker.dart';
import 'package:buku_saku_2/screens/app/notes/components/detail_box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_file/open_file.dart';

class NoteDetailScreen extends StatefulWidget {
  const NoteDetailScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  var dbHelper = DbHelper();

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
                          const SizedBox(height: 10),
                          DetailBox(
                            children: <Widget>[
                              WhiteBoxBody(
                                title: "Jenjang",
                                body: "note.jenjang!",
                              ),
                              // nambah date created di screen ini
                              WhiteBoxBody(
                                title: "Butir Kegiatan",
                                widgetBody: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      note.kodeButir!,
                                      style: AppConstants.kDetailCardTextStyle,
                                    ),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: Text(
                                        note.judul!.substring(
                                            note.judul!.indexOf(" ") + 1),
                                        style:
                                            AppConstants.kDetailCardTextStyle,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          DetailBox(
                            children: <Widget>[
                              WhiteBoxBody(
                                title: "Tanggal Kegiatan",
                                widgetBody: Row(
                                  children: note.listTanggal == null
                                      ? [const Text("-")]
                                      : List.generate(
                                          note.listTanggal!.length,
                                          (index) {
                                            return DatePill(
                                              date: note.listTanggal![index],
                                            );
                                          },
                                        ),
                                ),
                              ),
                            ],
                          ),
                          DetailBox(
                            children: <Widget>[
                              WhiteBoxBody(
                                title: "Uraian Kegiatan",
                                body: note.uraian,
                              ),
                              WhiteBoxBody(
                                title: "Jumlah Kegiatan",
                                body: note.jumlahKegiatan.toString(),
                              ),
                              WhiteBoxBody(
                                title: "Angka Kredit",
                                body: note.angkaKredit.toStringAsFixed(3),
                              ),
                            ],
                          ),
                          const DetailBox(
                            children: <Widget>[
                              WhiteBoxBody(
                                title: "Kegiatan Tim",
                                body:
                                    "Jumlah anggota tim : 3\nPeran : penyusun utama",
                              ),
                            ],
                          ),
                          DetailBox(
                            children: <Widget>[
                              WhiteBoxBody(
                                title: "Bukti Fisik",
                                widgetBody: (note.buktiFisik!.isNotEmpty)
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
                                                          .buktiFisik![index]
                                                          .path);
                                                    },
                                                    child: Center(
                                                        child: Text(
                                                            '${note.buktiFisik![index].namaFile}.${note.buktiFisik![index].extension}')),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                note.buktiFisik![index]
                                                    .namaFile,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    : const Text(
                                        'bukti belum ada (urus dulu sana)'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
                        final value = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddNoteScreen(note: note),
                          ),
                        );
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
