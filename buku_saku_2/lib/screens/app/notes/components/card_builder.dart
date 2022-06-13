import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:buku_saku_2/screens/app/notes/note_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CardBuilder extends StatelessWidget {
  final Note notes;
  final int? status;
  final Function? onLongPressed;

  // TODO : bikin logic ketika mau ganti status, harusnya sih di newNoteForm, bukan disini

  const CardBuilder({
    Key? key,
    required this.notes,
    this.status,
    this.onLongPressed,
  }) : super(key: key);

  getNoteIcon() {
    // if (pinned == true) {
    //   return Image.asset("assets/icons/pinned.png");
    // } else if (status == 2) {
    //   return Image.asset("assets/icons/important.png");
    // } else if (status == 0) {
    //   return Image.asset("assets/icons/checked.png");
    // } else {
    //   return const SizedBox();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.beige,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
        child: Container(
          decoration: const BoxDecoration(
            border:
                Border(left: BorderSide(color: AppColors.beigeDark, width: 7)),
            color: Colors.transparent,
          ),
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onLongPress: () async {
              var result = await showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Hapus Catatan'),
                  content:
                      const Text('Anda yakin ingin menghapus catatan ini ?'),
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

              if (result == 'Ya') {
                context.read<NotesProvider>().deleteNote(notes.id!);
              }
            },
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteDetailScreen(id: notes.id!),
                  ));
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      notes.judul!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppConstants.kCardTitleTextStyle,
                    ),
                    const SizedBox(height: 7),
                    Text(
                      notes.uraian,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: AppConstants.kCardBodyTextStyle,
                    ),
                    const SizedBox(height: 7),
                    Text(
                      DateFormat("d MMM yyyy", "id_ID")
                          .format(notes.dateCreated!),
                      textAlign: TextAlign.left,
                      style: AppConstants.kCardDateTextStyle,
                    ),
                  ],
                ),
                const Positioned(
                  height: 20,
                  width: 20,
                  right: 0,
                  bottom: 0,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
