import 'dart:io';

import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/models/db/database.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/kegiatan_tim.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/bukti_fisik_field.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/butir_dropdown.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/date_picker.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/jenjang_dropdown.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/jumlah_kegiatan_field.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/uraian_text_area.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class NewNoteForm extends StatefulWidget {
  const NewNoteForm({Key? key, this.note, this.selectedButir})
      : super(key: key);
  final Note? note;
  final ButirKegiatan? selectedButir;

  @override
  State<NewNoteForm> createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {
  final _formKey = GlobalKey<FormState>();

  // beberapa pindahin langsung ke tempat mereka, karena inis sifatnya konstan

  var dbHelper = DbHelper();

  late Note selectedNote;
  ButirKegiatan? selectedButir;
  String? alert;

  TextEditingController jmlAnggotaTextController =
      TextEditingController(text: "2");
  TextEditingController uraianTextController = TextEditingController();

  // belom ngabil dari db

  submitNote(NotesProvider noteProvider) async {
    if (_formKey.currentState!.validate()) {
      selectedNote.uraian = uraianTextController.text;
      selectedNote.jmlAnggota = int.parse(jmlAnggotaTextController.text);
      final Note newNote = selectedNote;

      print(newNote.toMap());
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
      uraianTextController.text = selectedNote.uraian;
    } else {
      selectedNote = Note(
        judul:
            widget.selectedButir != null ? widget.selectedButir!.judul : null,
        uraian: "",
        angkaKredit: widget.selectedButir != null
            ? widget.selectedButir!.angkaKredit
            : 0,
        listTanggal: [],
      );

      // keknya penggunaan selectedbutir bisa disederhanain lagi
      selectedButir = widget.selectedButir;
      if (selectedButir != null) {
        context.read<ProfileProvider>().setSelectedButir = selectedButir!;
        alert = context.read<ProfileProvider>().getAlert;
        selectedNote.judul = selectedButir!.kode + " " + selectedButir!.judul;
        selectedNote.kodeButir = selectedButir!.kode;
        selectedNote.angkaKredit = selectedButir!.angkaKredit;
        (alert == null)
            ? selectedNote.akSatuan = selectedButir!.angkaKredit
            : selectedNote.akSatuan = selectedButir!.angkaKredit * 0.8;
      }
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
          const JenjangDropdown(),
          ButirDropdown(
            editMode: (widget.note?.id != null),
            selectedData:
                (widget.note == null) ? selectedNote.judul : widget.note!.judul,
            alert: alert,
            onChanged: (butir) {
              setState(() {
                selectedButir = butir;
                selectedNote.judul = butir?.judul;
                alert = null;

                if (butir?.judul != null) {
                  context.read<ProfileProvider>().setSelectedButir =
                      selectedButir!;
                  alert = context.read<ProfileProvider>().getAlert;

                  selectedNote.judul = butir!.kode + " " + butir.judul;
                  selectedNote.kodeButir = butir.kode;
                  selectedNote.angkaKredit = butir.angkaKredit;
                  (alert == null)
                      ? selectedNote.akSatuan = butir.angkaKredit
                      : selectedNote.akSatuan = butir.angkaKredit * 0.8;
                }
              });
            },
          ),
          DatePicker(
            selectedDate: selectedNote.listTanggal!,
            onAdd: (value) {
              setState(() {
                if (value != null) selectedNote.listTanggal!.add(value);
              });
            },
            onReduced: (date) {
              setState(() {
                selectedNote.listTanggal!
                    .removeWhere((element) => element == date);
              });
            },
          ),
          UraianTextArea(controller: uraianTextController),
          JumlahKegiatanField(
            initialJmlKegiatan: selectedNote.jumlahKegiatan,
            akSatuan: selectedNote.akSatuan ?? 0,
            onChanged: (value) {
              setState(() {
                selectedNote.jumlahKegiatan = value;
                // harusnya nanti field setelah butir kegiatan muncul kalo butir kegiatan udh dipilih
                // dan angka kredit adanya setelah butir terpilih
                selectedNote.angkaKredit = value * selectedNote.akSatuan!;
              });
            },
          ),
          KegiatanTimField(
            isChecked: selectedNote.isTim,
            jmlAnggotaController: jmlAnggotaTextController,
            initialDataPeran: selectedNote.peranDalamTim,
            onCheckboxChanged: (bool? value) {
              setState(() {
                selectedNote.isTim = value!;
              });
            },
            onRadioButtonChanged: (String? value) {
              setState(() {
                selectedNote.peranDalamTim = value;
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
                namaFile: file.name,
                extension: file.extension!,
              );

              setState(() {
                selectedNote.buktiFisik?.add(newBukti);
              });
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
