import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/notes/components/new_note_form.dart';

class AddNoteScreen extends StatefulWidget {
  static const id = 'add_note_screen';
  const AddNoteScreen({Key? key, this.butirCode}) : super(key: key);
  final String? butirCode;

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  List<Widget> listViews = <Widget>[];

  // TODO : OTW bikin screen detail catatan (kalo bisa sih beda sama screen edit/tambah nya)

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
              title: 'Tambah Catatan',
              backButton: true,
              backButtonCallback: () {
                Navigator.pop(context);
              },
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
    return ListView(
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      scrollDirection: Axis.vertical,
      children: const <Widget>[
        NewNoteForm(id: 'tes'),
      ],
    );
  }
}
