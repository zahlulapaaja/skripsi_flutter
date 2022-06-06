import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/models/providers/dictionary_provider.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/notes/components/new_note_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  static const id = 'add_note_screen';
  const AddNoteScreen({Key? key, this.butir, this.note}) : super(key: key);
  final ButirKegiatan? butir;
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
                FutureBuilder(
                    future: context.read<DictionaryProvider>().readJsonData,
                    builder: (context, AsyncSnapshot<List<Unsur>> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                            child:
                                Text('error fetching data, ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        context.read<DictionaryProvider>().storeData =
                            snapshot.data!;

                        return NewNoteForm(
                            butir: widget.butir, note: widget.note);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
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
