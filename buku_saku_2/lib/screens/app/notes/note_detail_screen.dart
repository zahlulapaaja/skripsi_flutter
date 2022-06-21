import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/components.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/models/db/database.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:buku_saku_2/screens/app/notes/add_note_screen.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/date_picker.dart';
import 'package:buku_saku_2/screens/app/notes/components/detail_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

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
    String jenjang = context.read<ProfileProvider>().profil.jenjang!.jenjang;
    return FutureBuilder(
      future: dbHelper.getNoteById(widget.id),
      builder: (context, AsyncSnapshot<Note> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error fetching data: ${snapshot.error}'));
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
                              Text(
                                "Catatan dibuat pada : ${DateFormat("d MMMM yyyy", "id_ID").format(note.dateCreated!)}",
                                style: AppConstants.kTextFieldHintStyle,
                              ),
                              const SizedBox(height: 16),
                              WhiteBoxBody(
                                title: "Jenjang",
                                body: jenjang,
                              ),
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
                                widgetBody: Wrap(
                                  children: (note.listTanggal[0].tanggalMulai ==
                                          null)
                                      ? [const Text("-")]
                                      : List.generate(
                                          note.listTanggal.length,
                                          (index) {
                                            if (note.listTanggal[index]
                                                    .tanggalMulai !=
                                                null) {
                                              return DatePill(
                                                date: note.listTanggal[index],
                                              );
                                            } else {
                                              return const SizedBox();
                                            }
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
                                title: "Satuan Hasil",
                                body: note.satuanHasil,
                              ),
                              WhiteBoxBody(
                                title: "Jumlah Kegiatan",
                                body: note.jumlahKegiatan.toString(),
                              ),
                              WhiteBoxBody(
                                title: "Angka Kredit",
                                body: NumberFormatter.convertToId(
                                    note.angkaKredit),
                              ),
                            ],
                          ),
                          DetailBox(
                            children: <Widget>[
                              WhiteBoxBody(
                                title: "Kegiatan Tim",
                                body: (note.isTim)
                                    ? "Jumlah anggota tim : ${note.jmlAnggota}\nPeran : ${note.peranDalamTim}"
                                    : "-",
                              ),
                            ],
                          ),
                          DetailBox(
                            children: <Widget>[
                              WhiteBoxBody(
                                title: "Bukti Fisik",
                                subtitle:
                                    '(Anda mempunyai ${note.buktiFisik?.length ?? 0} bukti fisik)',
                                widgetBody: (note.buktiFisik!.isNotEmpty)
                                    ? GridView.builder(
                                        padding: const EdgeInsets.only(top: 10),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisExtent: 100,
                                          crossAxisCount: 3,
                                          childAspectRatio: 3 / 2,
                                          crossAxisSpacing: 15,
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
                                                  color: getCardColor(note
                                                      .buktiFisik![index]
                                                      .extension),
                                                  child: InkWell(
                                                    onTap: () {
                                                      OpenFile.open(note
                                                          .buktiFisik![index]
                                                          .path);
                                                    },
                                                    child: Center(
                                                        child: Text(
                                                            '.${note.buktiFisik![index].extension}')),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                note.buktiFisik![index].name,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    : const SizedBox(),
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
                        Icons.chevron_left,
                        color: AppColors.offWhite,
                        size: AppConstants.kHugeFontSize,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    rightIconButton: IconButton(
                      icon: const Icon(
                        Icons.edit_note_rounded,
                        color: AppColors.offWhite,
                        size: AppConstants.kHugeFontSize,
                      ),
                      onPressed: () async {
                        final value = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddNoteScreen(note: note),
                          ),
                        );

                        if (value == 'refresh') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    super.widget),
                          );
                        }
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

  Color? getCardColor(String extension) {
    switch (extension) {
      case 'pdf':
        return AppColors.beigeDark;
      case 'docx':
        return AppColors.beigeDark;
      case 'png':
        return AppColors.info;
      case 'jpg':
        return AppColors.info;
      case 'xlsx':
        return AppColors.success;
      case 'csv':
        return AppColors.success;
      default:
        return AppColors.lightGrey;
    }
  }
}
