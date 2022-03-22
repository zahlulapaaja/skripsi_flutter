import 'package:flutter/material.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/bukti_fisik_field.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/butir_dropdown.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/date_picker.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/jenjang_dropdown.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/jumlah_kegiatan_field.dart';
import 'package:buku_saku_2/screens/app/notes/components/form_field/uraian_text_area.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/notes_provider.dart';
import 'package:buku_saku_2/screens/app/models/dictionary_provider.dart';
import 'package:provider/provider.dart';

class NewNoteForm extends StatefulWidget {
  const NewNoteForm({Key? key, this.id, this.kodeButir}) : super(key: key);
  final String? id;
  final String? kodeButir;

  @override
  State<NewNoteForm> createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {
  final _formKey = GlobalKey<FormState>();
  int? selectedIndex;
  List<String> dataButir = [];
  List<String> dataJenjang = [];
  int maxJmlKegiatan = 10;
  bool maxKegiatan = false;
  bool minKegiatan = false;

  getData(NotesProvider noteProvider, DictionaryProvider dictProvider) {
    dataButir = List<String>.generate(
      dictProvider.allButir.length,
      (index) {
        if (widget.kodeButir == dictProvider.allButir[index]['kode']) {
          selectedIndex = index;
        }
        return dictProvider.allButir[index]['kode'] +
            " " +
            dictProvider.allButir[index]['judul'];
      },
      growable: true,
    );

    dataJenjang = noteProvider.jenjang;
  }

  Map<String, dynamic> selectedData = {
    // tapi disini ga perlu deklarasi kan
    'butir': 'Sesuatu',
    'jenjang': 'Sesuatu',
    'date': DateTime.now(),
    'uraian': 'Sesuatu',
    'jml_kegiatan': 1,
    'angka_kredit': 0.104,
    // nanti yg dibawah ini bikinnya pake tipe List bool
    'is_checked_bukti': {0: false},
  };

  submitNote(NotesProvider noteProvider) async {
    if (_formKey.currentState!.validate()) {
      final newNote = Note(
        judul: selectedData['butir'],
        uraian: selectedData['uraian'],
        kodeButir: '',
        tanggalKegiatan: selectedData['date'].toString(),
        jumlahKegiatan: selectedData['jml_kegiatan'],
        angkaKredit: selectedData['angka_kredit'],
        status: 1,
        personId: 1,
      );

      noteProvider.addNewNote(newNote);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NotesProvider>(context);
    final dictProvider = Provider.of<DictionaryProvider>(context);
    getData(noteProvider, dictProvider);

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          ButirDropdown(
            dataButir: dataButir,
            selectedIndex: selectedIndex,
            onChanged: (value) {
              setState(() {
                selectedData['butir'] = value;
              });
            },
          ),
          JenjangDropdown(
              dataJenjang: dataJenjang,
              onChanged: (value) => selectedData['jenjang']),
          DatePicker(
            selectedDate: selectedData['date'],
            onChanged: (value) {
              setState(() {
                if (value != null) {
                  selectedData['date'] = value;
                }
              });
            },
          ),
          UraianTextArea(
            onChanged: (value) {
              selectedData['uraian'] = value;
            },
          ),
          JumlahKegiatanField(
            angkaKredit: selectedData['angka_kredit'],
            max: maxJmlKegiatan,
            onIncrement: (value) {
              selectedData['jml_kegiatan'] = value;
              setState(() {
                if (value == maxJmlKegiatan) {
                  if (!maxKegiatan) selectedData['angka_kredit'] += 0.104;
                  maxKegiatan = true;
                } else {
                  maxKegiatan = false;
                  minKegiatan = false;
                  selectedData['angka_kredit'] += 0.104;
                }
              });
            },
            onDecrement: (value) {
              selectedData['jml_kegiatan'] = value;
              setState(() {
                if (value == 1) {
                  if (!minKegiatan) selectedData['angka_kredit'] -= 0.104;
                  minKegiatan = true;
                } else {
                  minKegiatan = false;
                  maxKegiatan = false;
                  selectedData['angka_kredit'] -= 0.104;
                }
              });
            },
            onChanged: (value) {
              selectedData['jml_kegiatan'] = value;
              setState(() {
                selectedData['angka_kredit'] = value * 0.104;
              });
            },
          ),
          BuktiFisikField(
            selectedData: selectedData['is_checked_bukti'],
          ),
          ElevatedButton(
            onPressed: () => submitNote(noteProvider),
            child: const Text('Gass'),
          )
        ],
      ),
    );
  }
}
