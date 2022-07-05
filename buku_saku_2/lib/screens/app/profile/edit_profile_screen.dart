import 'dart:io';

import 'package:buku_saku_2/configs/components.dart';
import 'package:buku_saku_2/screens/app/app_screen.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/models/db/db_profile.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:buku_saku_2/screens/app/models/providers/dictionary_provider.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:buku_saku_2/screens/app/profile/components/dropdown_field.dart';
import 'package:buku_saku_2/screens/app/profile/components/profile_form_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  static const id = 'edit_profile_screen';
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  var dbHelper = DbProfile();
  final _nameTextController = TextEditingController();
  final _akSaatIniTextController = TextEditingController();

  String? selectedJenjang;
  String? selectedGolongan;
  List<String> jenjang = [];
  List<String> golongan = [];
  PlatformFile? selectedPhoto;

  Profile? selectedData;

  @override
  void initState() {
    selectedData = context.read<ProfileProvider>().profil;
    for (var item in selectedData!.listJenjang!) {
      if (jenjang.isEmpty) {
        jenjang.add(item.jenjang);
      } else if (item.jenjang != jenjang.last) {
        jenjang.add(item.jenjang);
      }
    }

    if (selectedData!.id != null) {
      _nameTextController.text = selectedData!.nama!;
      _akSaatIniTextController.text =
          AppComponents.convertNumberToId(selectedData!.akSaatIni);
      if (selectedData!.fotoProfil != null) {
        selectedPhoto = PlatformFile.fromMap(selectedData!.toProfileMap());
      }
      for (var item in selectedData!.listJenjang!) {
        if (item.id == selectedData!.jenjang!.id) {
          selectedJenjang = item.jenjang;
          selectedGolongan = item.golongan;
        }
        if (item.kodeJenjang == selectedData!.jenjang!.kodeJenjang) {
          golongan.add(item.golongan);
        }
      }
    }
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
            getMainListViewUI(context),
            AppBarUI(
              title: 'Edit Profil',
              leftIconButton: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  color: AppColors.offWhite,
                  size: AppConstants.kHugeFontSize,
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

  Widget getMainListViewUI(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.only(
          top: AppBar().preferredSize.height +
              MediaQuery.of(context).padding.top,
          bottom: 62 + MediaQuery.of(context).padding.bottom,
          left: 20,
          right: 20,
        ),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          const FieldLabel(title: "Foto Profil"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppColors.grey.withOpacity(0.4),
                        offset: const Offset(2.0, 4.0),
                        blurRadius: 2),
                  ],
                ),
                child: InkWell(
                  onTap: uploadImage,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                    child: (selectedPhoto != null)
                        ? Image.file(
                            File(selectedPhoto!.path!),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/icons/profile.png",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    onPressed: uploadImage,
                    child: const Text("Upload"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var result = await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Hapus Foto'),
                          content: const Text(
                              'Anda yakin ingin menghapus foto profil ?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Tidak'),
                              child: const Text('Tidak'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Ya'),
                              child: const Text('Ya'),
                            ),
                          ],
                        ),
                      );
                      setState(() {
                        if (result == "Ya") selectedPhoto = null;
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.alert)),
                    child: const Text("Hapus"),
                  ),
                ],
              ),
            ],
          ),
          ProfileFormField(
            title: "Nama Lengkap",
            hintText: "Masukkan nama lengkap Anda...",
            controller: _nameTextController,
            keyboardType: TextInputType.text,
          ),
          DropdownField(
            title: "Jenjang",
            data: jenjang,
            initialData: selectedJenjang,
            hintText: "Pilih jenjang...",
            onChanged: (value) {
              setState(() {
                selectedJenjang = value;
                selectedGolongan = null;
                golongan = [];
                for (var item in selectedData!.listJenjang!) {
                  if (item.jenjang == value) {
                    golongan.add(item.golongan);
                  }
                }
              });
            },
          ),
          DropdownField(
            title: "Golongan",
            data: golongan,
            initialData: selectedGolongan,
            hintText: "Pilih golongan...",
            onChanged: (value) {
              for (var row in selectedData!.listJenjang!) {
                if (row.jenjang == selectedJenjang && row.golongan == value) {
                  setState(() {
                    selectedData!.jenjang = row;
                  });
                }
              }
            },
          ),
          ProfileFormField(
            title: "Angka Kredit Saat Ini",
            hintText: "Masukkan angka kredit Anda saat ini...",
            controller: _akSaatIniTextController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 40),
          BlueRoundedButton(
            buttonTitle: 'Simpan',
            onPressed: () {
              saveData(selectedData!);
            },
          ),
        ],
      ),
    );
  }

  void uploadImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    if (result != null) {
      setState(() {
        selectedPhoto = result.files.first;
      });
    }
  }

  saveData(Profile data) async {
    if (_formKey.currentState!.validate()) {
      data.nama = _nameTextController.text;
      data.akSaatIni = double.parse(
          _akSaatIniTextController.text.replaceAll(RegExp(r','), '.'));
      if (data.fotoProfil != null) File(data.fotoProfil!).delete();
      if (selectedPhoto != null) {
        final file = await saveFilePermanently(selectedPhoto!);
        data.fotoProfil = file.path;
      } else {
        data.fotoProfil = null;
      }

      int status = await context.read<ProfileProvider>().saveProfile(data);

      if (status == 1) {
        context.read<DictionaryProvider>().setJenjang = data;
        AppComponents.toastAlert(
          msg: "Data berhasil disimpan",
          color: AppColors.success,
        );
        (data.id == null)
            ? Navigator.pushNamed(context, AppScreen.id)
            : Navigator.pop(context);
      }
    }
  }

  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');

    return File(file.path!).copy(newFile.path);
  }
}
