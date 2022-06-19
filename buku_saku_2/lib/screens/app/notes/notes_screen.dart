import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/notes/components/card_list_view.dart';
import 'package:buku_saku_2/screens/app/notes/components/card_grid_view.dart';
import 'package:buku_saku_2/screens/app/notes/components/note_searchbox.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class NotesScreen extends StatefulWidget {
  static const id = 'notes_screen';
  const NotesScreen({Key? key}) : super(key: key);
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  bool isListView = false;

  @override
  void initState() {
    Fluttertoast.showToast(
      msg: "Tahan catatan untuk hapus",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.primaryLight.withOpacity(0.6),
      textColor: Colors.white,
      fontSize: AppConstants.kTinyFontSize,
    );
    super.initState();
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
              title: 'Catatan',
              rightIconButton: IconButton(
                icon: Image.asset(
                  isListView
                      ? "assets/icons/card_view.png"
                      : "assets/icons/list_view.png",
                ),
                onPressed: () {
                  setState(() {
                    isListView = !isListView;
                  });
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
    context.read<NotesProvider>().orderByKodeButir = true;

    return ListView(
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      scrollDirection: Axis.vertical,
      children: <Widget>[
        NoteSearchBox(),
        isListView ? const CardListView() : const CardGridView(),
      ],
    );
  }
}
