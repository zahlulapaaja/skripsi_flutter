import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:buku_saku_2/screens/app/notes/note_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CardBuilder extends StatelessWidget {
  final Note notes;
  final String? date;
  final Function? onLongPressed;

  //sementara
  final int? index;
  final bool? pinned;

  // TODO : Tambah atribut yang lengkap disini
  // Dan bikin kondisi, kalo lagi dalam kondisi edit, ada tambahan input kayak status, dsb

  const CardBuilder({
    Key? key,
    required this.notes,
    this.index,
    this.date,
    // required this.tag,
    this.pinned = false,
    this.onLongPressed,
  }) : super(key: key);

  getNoteIcon() {
    if (pinned == true) {
      return SvgPicture.asset("assets/icons/pinned.svg");
    } else if (index == 2) {
      return SvgPicture.asset("assets/icons/important.svg");
    } else if (index == 0) {
      return SvgPicture.asset("assets/icons/checked.svg");
    } else {
      return const SizedBox();
    }
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
                  content: const Text('Hapus ga ni ??'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );

              if (result == 'OK') {
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
                      maxLines: index == 1 ? 10 : 5,
                      overflow: TextOverflow.ellipsis,
                      style: AppConstants.kCardBodyTextStyle,
                    ),
                    const SizedBox(height: 7),
                    Text(
                      date!,
                      textAlign: TextAlign.left,
                      style: AppConstants.kCardDateTextStyle,
                    ),
                  ],
                ),
                Positioned(
                  height: 20,
                  width: 20,
                  right: 0,
                  bottom: 0,
                  child: getNoteIcon(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
