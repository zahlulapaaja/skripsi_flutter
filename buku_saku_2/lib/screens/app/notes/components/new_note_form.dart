import 'dart:io';

import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/models/db/database.dart';
import 'package:buku_saku_2/screens/app/models/doc_file.dart';
import 'package:buku_saku_2/screens/app/models/providers/dictionary_provider.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/kegiatan_tim.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/spmk_field.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/bukti_fisik_field.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/butir_dropdown.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/date_picker.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/jenjang_dropdown.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/jumlah_kegiatan_field.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/uraian_text_area.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:provider/provider.dart';

class NewNoteForm extends StatefulWidget {
  const NewNoteForm({Key? key, this.note, this.selectedButir, this.saveButton})
      : super(key: key);
  final Note? note;
  final ButirKegiatan? selectedButir;
  final Function()? saveButton;

  @override
  State<NewNoteForm> createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {
  final _formKey = GlobalKey<FormState>();

  var dbHelper = DbHelper();

  late Note selectedNote;
  ButirKegiatan? selectedButir;
  List<PlatformFile> selectedBuktiFisik = [];
  PlatformFile? selectedSPMK;
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

  submitNote() async {
    if (_formKey.currentState!.validate()) {
      selectedNote.uraian = uraianTextController.text;
      selectedNote.angkaKredit =
          selectedNote.jumlahKegiatan * selectedNote.akSatuan!;
      selectedNote.listTanggal.take(selectedNote.jumlahKegiatan);

      selectedNote.buktiFisik?.clear();
      for (var file in selectedBuktiFisik) {
        final newFile = await DocFile.saveFiles(file);
        selectedNote.buktiFisik!.add(DocFile(
          path: newFile.path,
          name: file.name,
          extension: file.extension!,
        ));
      }

      if (selectedSPMK != null) {
        final spmk = await DocFile.saveFiles(selectedSPMK!);
        selectedNote.spmk = DocFile(
          path: spmk.path,
          name: selectedSPMK!.name,
          extension: selectedSPMK!.extension!,
          size: selectedSPMK!.size,
        );
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
      if (selectedNote.listTanggal.isEmpty) {
        selectedNote.listTanggal = [TanggalKegiatan()];
      }
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
        listTanggal: [TanggalKegiatan()],
        buktiFisik: [],
      );

      selectedButir = widget.selectedButir;
      if (selectedButir != null) {
        Future.delayed(Duration.zero, () {
          context.read<ProfileProvider>().setSelectedButir = selectedButir!;
        });
        alert = context.read<ProfileProvider>().getAlert;
        selectedNote.judul = selectedButir!.kode + " " + selectedButir!.judul;
        selectedNote.kodeButir = selectedButir!.kode;
        selectedNote.angkaKredit = selectedButir!.angkaKredit;
        selectedNote.satuanHasil = selectedButir!.satuanHasil;
        (alert == null)
            ? selectedNote.akSatuan = selectedButir!.angkaKredit
            : selectedNote.akSatuan = selectedButir!.angkaKredit * 0.8;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  selectedNote.satuanHasil = butir.satuanHasil;
                  (alert == null)
                      ? selectedNote.akSatuan = butir.angkaKredit
                      : selectedNote.akSatuan = butir.angkaKredit * 0.8;
                }
              });
            },
          ),
          if (selectedNote.judul != null)
            Column(
              children: <Widget>[
                DatePicker(
                  selectedDate: selectedNote.listTanggal,
                  jmlKegiatan: selectedNote.jumlahKegiatan,
                  onChangeTanggalMulai: (date, index) {
                    setState(() {
                      selectedNote.listTanggal[index].tanggalMulai = date;
                      if (date == null) {
                        selectedNote.listTanggal[index].tanggalBerakhir = date;
                      }
                    });
                  },
                  onChangeTanggalBerakhir: (date, index) {
                    setState(() {
                      selectedNote.listTanggal[index].tanggalBerakhir = date;
                    });
                  },
                ),
                UraianTextArea(controller: uraianTextController),
                JumlahKegiatanField(
                  initialJmlKegiatan: selectedNote.jumlahKegiatan,
                  akSatuan: selectedNote.akSatuan ?? 0,
                  onChanged: (value) {
                    setState(() {
                      for (var i = 0; i < value; i++) {
                        if (value >= selectedNote.listTanggal.length) {
                          selectedNote.listTanggal.add(TanggalKegiatan());
                        }
                      }
                      selectedNote.jumlahKegiatan = value;
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
                    final result = await DocFile.uploadFiles();
                    if (result == null) return;
                    setState(() {
                      selectedBuktiFisik.addAll(result.files);
                    });
                  },
                  onDelete: (value) {
                    setState(() {
                      File(value.path!).delete();
                      selectedBuktiFisik.remove(value);
                    });
                  },
                ),
                SPMKField(
                  selectedData: selectedSPMK,
                  onPressed: () async {
                    final result =
                        await DocFile.uploadFiles(allowMultiple: false);
                    if (result == null) return;
                    setState(() {
                      selectedSPMK = result.files.first;
                    });
                  },
                  onDelete: (value) {
                    setState(() {
                      File(value.path!).delete();
                      selectedBuktiFisik.remove(value);
                    });
                  },
                ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.primaryLight,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                alignment: Alignment.center,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onPressed: () => submitNote(),
              child: const Text('SIMPAN'),
            ),
          )
        ],
      ),
    );
  }
}
