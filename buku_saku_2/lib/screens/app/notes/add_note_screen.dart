import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/notes/components/new_note_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddNoteScreen extends StatefulWidget {
  static const id = 'add_note_screen';
  const AddNoteScreen({Key? key, this.butirTitle, this.note}) : super(key: key);
  final String? butirTitle;
  final Note? note;

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
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
                NewNoteForm(butirTitle: widget.butirTitle, note: widget.note),
              ],
            ),
            AppBarUI(
              title: (widget.note == null) ? 'Tambah Catatan' : 'Edit Catatan',
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
  }
}
