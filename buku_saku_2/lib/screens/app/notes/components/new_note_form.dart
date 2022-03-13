import 'package:buku_saku_2/screens/app/app_screen.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/database.dart';
import 'package:buku_saku_2/screens/app/models/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:provider/provider.dart';

class NewNoteForm extends StatefulWidget {
  const NewNoteForm({Key? key}) : super(key: key);

  @override
  State<NewNoteForm> createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {
  final List<String> dataButir = [
    'I.B.1. Melakukan pengumpulan informasi mengenai data instansi',
    'I.A.1. Melakukan Pemenuhan Permintaan dan Layanan Teknologi Informasi',
    'I.C.2. Melakukan Pengumpulan Dokumen untuk Kebutuhan Audit TI',
  ];
  final List<String> dataJenjang = [
    'Prakom Ahli Pertama',
    'Prakom Ahli Madya',
    'Prakom Ahli Utama'
  ];

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

  var dbHelper;

  @override
  void initState() {
    super.initState();
    addCheckboxBukti(index: 0);
    dbHelper = DbHelper();
  }

  final _formKey = GlobalKey<FormState>();
  List<Widget> checkboxBukti = [
    const FieldLabel(title: 'Bukti Fisik'),
  ];

  addCheckboxBukti({required int index}) {
    if (selectedData['is_checked_bukti'][index] == null) {
      selectedData['is_checked_bukti'][index] = false;
    }

    // TODO : Masih belom berrubah tampilannya ketika diklik, tapi nilainya udh berubah
    // tapi abis itu ga berubah lagi sih, cma sekali berubahnya

    checkboxBukti.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  checkColor: Colors.white,
                  // fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: selectedData['is_checked_bukti'][index],
                  onChanged: (bool? value) {
                    print('test');
                    print(index);
                    print(value);
                    setState(() {
                      selectedData['is_checked_bukti'][index] =
                          !selectedData['is_checked_bukti'][index];
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              Text('Disini nama buktinya apa'),
            ],
          ),
          Row(
            children: [
              Icon(FontAwesomeIcons.times),
              Icon(FontAwesomeIcons.eye),
            ],
          ),
        ],
      ),
    );
  }

  submitNote(context) async {
    // if (_formKey.currentState!.validate()) {
    //   //   final newNote = Note(
    //   //     title: selectedData['butir'],
    //   //     body: selectedData['uraian'],
    //   //   );
    //   //
    //   //   // klo cuma pop datanya jadi ga keload
    //   await context.read<Note>().addNewNote();
    //
    //   // .saveNote(newNote)
    //   // .then({Navigator.pushNamed(context, AppScreen.id)});
    // }
  }

  removeCheckboxBukti() {
    checkboxBukti.removeLast();
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NotesProvider>(context);
    var dbHelper = DbHelper();
    Future<void> addUsers() async {
      Note firstUser = Note(
        title: 'Some thing',
        body: 'Iya something gitu',
      );

      /*
User secondUser = User(
        name: userProvider.userTwo.name,
        location: userProvider.userTwo.location,
      );

      User thirddUser = User(
        name: userProvider.userThree.name,
        location: userProvider.userThree.location,
      );
*/
      // List<Note> listOfUsers = [
      //   firstUser,
      //   //secondUser,
      //   //thirddUser,
      // ];
      return await dbHelper.saveNote(firstUser);
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const FieldLabel(title: 'Jenjang'),
                DropdownSearch<String>(
                  mode: Mode.BOTTOM_SHEET,
                  showClearButton: true,
                  items: dataButir,
                  hint: "Jenjang Jabatan saat ini",
                  // popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: (value) {
                    selectedData['butir'] = value;
                  },
                  selectedItem: dataButir[0],
                  dropdownSearchDecoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.black,
                        width: 2.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const FieldLabel(title: 'Jenjang'),
                DropdownSearch<String>(
                  mode: Mode.BOTTOM_SHEET,
                  showClearButton: true,
                  items: dataJenjang,
                  hint: "Jenjang Jabatan saat ini",
                  // popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: (value) {
                    selectedData['jenjang'] = value;
                  },
                  selectedItem: dataJenjang[0],
                  dropdownSearchDecoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.black,
                        width: 2.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const FieldLabel(title: 'Tanggal Kegiatan'),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectedData['date'].day.toString() +
                          " " +
                          selectedData['date'].month.toString() +
                          " " +
                          selectedData['date'].year.toString()),
                      TextButton(
                        child: Icon(FontAwesomeIcons.calendar),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: selectedData['date'],
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2040),
                          ).then((value) {
                            setState(() {
                              if (value != null) {
                                selectedData['date'] = value;
                              }
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const FieldLabel(title: 'Uraian Kegiatan'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      maxLines: 8,
                      decoration: InputDecoration.collapsed(
                          hintText: "Enter your text here"),
                      onChanged: (value) {
                        selectedData['uraian'] = value;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const FieldLabel(title: 'Jumlah Kegiatan'),
                        Expanded(
                          child: NumberInputWithIncrementDecrement(
                            onChanged: (value) {
                              print(value);
                              selectedData['jml_kegiatan'] = value;
                            },
                            onIncrement: (value) {
                              selectedData['jml_kegiatan'] = value.toInt();
                              setState(() {
                                selectedData['angka_kredit'] += 0.104;
                                addCheckboxBukti(index: value.toInt() - 1);
                              });
                            },
                            onDecrement: (value) {
                              selectedData['jml_kegiatan'] = value.toInt();
                              setState(() {
                                selectedData['angka_kredit'] -= 0.104;
                                removeCheckboxBukti();
                              });
                            },
                            controller: TextEditingController(),
                            decIconSize: 20,
                            incIconSize: 20,
                            initialValue: 1,
                            min: 1,
                            max: 10,
                            numberFieldDecoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const FieldLabel(title: 'Angka Kredit'),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: AppColors.black),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Text('${selectedData['angka_kredit']}'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: checkboxBukti,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              print('test');
              print(selectedData);
              if (_formKey.currentState!.validate()) {
                final newNote = Note(
                  title: selectedData['butir'],
                  body: selectedData['uraian'],
                );
                //
                //   // klo cuma pop datanya jadi ga keload
                // context
                //     .read<NotesProvider>()
                //     .addNewNote(selectedData['butir'], selectedData['uraian']);

                noteProvider.addingNotes(newNote);

                Navigator.pop(context);

                // .saveNote(newNote)
                // .then({Navigator.pushNamed(context, AppScreen.id)});
              }
            },
            child: Text('Gass'),
          )
        ],
      ),
    );
  }
}
