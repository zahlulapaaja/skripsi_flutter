import 'dart:io';

import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/models/db/database.dart';
import 'package:buku_saku_2/screens/app/models/providers/dictionary_provider.dart';
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

  var dbHelper = DbHelper();

  late Note selectedNote;
  ButirKegiatan? selectedButir;
  List<PlatformFile> selectedBuktiFisik = [];
  String? alert;
  TextEditingController uraianTextController = TextEditingController();

  void notifyAKSatuan() {
    (alert == null)
        ? selectedNote.akSatuan = selectedButir!.angkaKredit
        : selectedNote.akSatuan = selectedButir!.angkaKredit * 0.8;
    if (selectedNote.isTim && selectedNote.jmlAnggota >= 2) {
      switch (selectedNote.jmlAnggota) {
        case 2:
          if (selectedNote.peranDalamTim == "penyusun utama") {
            selectedNote.akSatuan = selectedNote.akSatuan! * 0.6;
          } else if (selectedNote.peranDalamTim == "penyusun pembantu") {
            selectedNote.akSatuan = selectedNote.akSatuan! * 0.4;
          } else {
            selectedNote.akSatuan = selectedNote.akSatuan! / 2;
          }
          break;
        case 3:
          if (selectedNote.peranDalamTim == "penyusun utama") {
            selectedNote.akSatuan = selectedNote.akSatuan! * 0.5;
          } else if (selectedNote.peranDalamTim == "penyusun pembantu") {
            selectedNote.akSatuan = selectedNote.akSatuan! * 0.25;
          } else {
            selectedNote.akSatuan = selectedNote.akSatuan! / 3;
          }
          break;
        case 4:
          if (selectedNote.peranDalamTim == "penyusun utama") {
            selectedNote.akSatuan = selectedNote.akSatuan! * 0.4;
          } else if (selectedNote.peranDalamTim == "penyusun pembantu") {
            selectedNote.akSatuan = selectedNote.akSatuan! * 0.2;
          } else {
            selectedNote.akSatuan = selectedNote.akSatuan! / 4;
          }
          break;
        default:
          if (selectedNote.peranDalamTim == "penyusun utama") {
            selectedNote.akSatuan = selectedNote.akSatuan! * 0.3;
          } else if (selectedNote.peranDalamTim == "penyusun pembantu") {
            selectedNote.akSatuan = selectedNote.akSatuan! * 0.15;
          } else {
            selectedNote.akSatuan = selectedNote.akSatuan! * 0.15;
          }
          break;
      }
    }
  }

  submitNote(NotesProvider noteProvider) async {
    if (_formKey.currentState!.validate()) {
      selectedNote.uraian = uraianTextController.text;
      selectedNote.angkaKredit =
          selectedNote.jumlahKegiatan * selectedNote.akSatuan!;

      selectedNote.buktiFisik?.clear();
      for (var file in selectedBuktiFisik) {
        final newFile = await saveFilePermanently(file);
        selectedNote.buktiFisik!.add(DocFile(
          path: newFile.path,
          name: file.name,
          extension: file.extension!,
        ));
      }

      final Note newNote = selectedNote;

      (widget.note?.id != null)
          ? await dbHelper.updateNote(newNote)
          : await dbHelper.saveNote(newNote);
      Navigator.pop(context, 'refresh');
    }
  }

  @override
  void initState() {
    if (widget.note != null) {
      selectedNote = widget.note!;
      uraianTextController.text = selectedNote.uraian;
      selectedNote.buktiFisik?.forEach((docFile) {
        selectedBuktiFisik.add(PlatformFile.fromMap(docFile.toMap()));
      });
      Future.delayed(Duration.zero, () {
        selectedButir = context
            .read<DictionaryProvider>()
            .getButirByKode(selectedNote.kodeButir!);
        context.read<ProfileProvider>().setSelectedButir = selectedButir!;
        alert = context.read<ProfileProvider>().getAlert;
      });
    } else {
      selectedNote = Note(
        judul:
            widget.selectedButir != null ? widget.selectedButir!.judul : null,
        uraian: "",
        angkaKredit: widget.selectedButir != null
            ? widget.selectedButir!.angkaKredit
            : 0,
        dateCreated: DateTime.now(),
        listTanggal: [],
        buktiFisik: [],
      );

      // todo : jangan lupa logika untuk custom satuan ak jika kegiatan tim (selain dari 80% ini)
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
              });
            },
          ),
          KegiatanTimField(
            isChecked: selectedNote.isTim,
            initialDataPeran: selectedNote.peranDalamTim,
            initialJmlAnggota: selectedNote.jmlAnggota,
            onTextFieldChanged: (int? value) {
              setState(() {
                selectedNote.jmlAnggota = value!;
                notifyAKSatuan();
              });
            },
            onCheckboxChanged: (bool? value) {
              setState(() {
                selectedNote.isTim = value!;
                notifyAKSatuan();
              });
            },
            onRadioButtonChanged: (String? value) {
              setState(() {
                selectedNote.peranDalamTim = value;
                notifyAKSatuan();
              });
            },
          ),
          BuktiFisikField(
            selectedData: selectedBuktiFisik,
            onPressed: () async {
              final result =
                  await FilePicker.platform.pickFiles(allowMultiple: true);
              if (result == null) return;
              setState(() {
                selectedBuktiFisik.addAll(result.files);
              });
            },
            onDelete: (fileName) {
              setState(() async {
                for (var file in selectedBuktiFisik) {
                  if (file.name == fileName) {
                    if (await File(file.path!).exists()) {
                      File(file.path!).delete();
                    }
                    selectedBuktiFisik.remove(file);
                  }
                }
              });
            },
          ),

          // todo : ini tombolnya mau dibawa kemana
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: ElevatedButton(
              onPressed: () => submitNote(noteProvider),
              child: const Text('Gass'),
            ),
          )
        ],
      ),
    );
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');

    // ParseFileBase parseFile;

    // parseFile = ParseFile(File(file.path!));

    // ParseResponse res = await parseFile.save();

    // res();

    // OpenFile(res.result);

    return File(file.path!).copy(newFile.path);
    // return File(file.path!);
  }
}
