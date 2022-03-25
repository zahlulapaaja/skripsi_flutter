import 'dart:io';

import 'package:buku_saku_2/screens/app/models/database.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/screens/app/models/bukti_fisik.dart';
import 'package:file_picker/file_picker.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/bukti_fisik_field.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/butir_dropdown.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/date_picker.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/jenjang_dropdown.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/jumlah_kegiatan_field.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/uraian_text_area.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/notes_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class NewNoteForm extends StatefulWidget {
  const NewNoteForm({Key? key, this.note, this.kodeButir}) : super(key: key);
  final Note? note;
  final String? kodeButir;

  @override
  State<NewNoteForm> createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {
  final _formKey = GlobalKey<FormState>();
  int maxJmlKegiatan = 10;
  bool maxKegiatan = false;
  bool minKegiatan = false;
  var dbHelper = DbHelper();

  Note selectedNote = Note(judul: '', uraian: '');

  submitNote(NotesProvider noteProvider) async {
    if (_formKey.currentState!.validate()) {
      final newNote = selectedNote;

      (widget.note?.id != null)
          ? noteProvider.updateNote(newNote)
          : noteProvider.addNewNote(newNote);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    if (widget.note != null) {
      selectedNote = widget.note!;
    } else {
      selectedNote.angkaKredit = 0.104;
      selectedNote.buktiFisik = [];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NotesProvider>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          ButirDropdown(
            editMode: (widget.note?.id != null),
            initialData: widget.note?.judul,
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  selectedNote.judul = value;
                  selectedNote.kodeButir = value.split(' ')[0];
                } else {
                  selectedNote.judul = '';
                  selectedNote.kodeButir = '';
                }
              });
            },
          ),
          JenjangDropdown(
            initialData: widget.note?.jenjang,
            onChanged: (value) => selectedNote.jenjang,
          ),
          DatePicker(
            initialDate: selectedNote.tanggalKegiatan,
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  selectedNote.tanggalKegiatan = value;
                }
              });
            },
          ),
          UraianTextArea(
            initialData: selectedNote.uraian,
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  selectedNote.uraian = value;
                }
              });
            },
          ),
          JumlahKegiatanField(
            // 0.104 nanti diganti jadi butir terpilih
            initialJmlKegiatan: selectedNote.jumlahKegiatan,
            initialAngkaKredit: selectedNote.angkaKredit,
            max: maxJmlKegiatan,
            onIncrement: (value) {
              selectedNote.jumlahKegiatan = value.toInt();
              setState(() {
                if (value == maxJmlKegiatan) {
                  if (!maxKegiatan) selectedNote.angkaKredit += 0.104;
                  maxKegiatan = true;
                } else {
                  maxKegiatan = false;
                  minKegiatan = false;
                  selectedNote.angkaKredit += 0.104;
                }
              });
            },
            onDecrement: (value) {
              selectedNote.jumlahKegiatan = value.toInt();
              setState(() {
                if (value == 1) {
                  if (!minKegiatan) selectedNote.angkaKredit -= 0.104;
                  minKegiatan = true;
                } else {
                  minKegiatan = false;
                  maxKegiatan = false;
                  selectedNote.angkaKredit -= 0.104;
                }
              });
            },
            onChanged: (value) {
              selectedNote.jumlahKegiatan = value.toInt();
              setState(() {
                selectedNote.angkaKredit = value * 0.104;
              });
            },
          ),
          BuktiFisikField(
            selectedData: selectedNote.buktiFisik,
            onPressed: () async {
              final result =
                  await FilePicker.platform.pickFiles(allowMultiple: true);
              if (result == null) return;

              final file = result.files.first;

              // harusnya nanti klo udh tekan save baru save permanent
              final newFile = await saveFilePermanently(file);
              final newBukti = BuktiFisik(
                path: newFile.path,
                fileName: file.name,
                extension: file.extension,
              );

              setState(() {
                selectedNote.buktiFisik!.add(newBukti);
              });

              print('From path: ${file.path}');
              print('To path: ${newFile.path}');
            },
          ),
          ElevatedButton(
            onPressed: () => submitNote(noteProvider),
            child: const Text('Gass'),
          )
        ],
      ),
    );
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');

    return File(file.path!).copy(newFile.path);
  }
}
