import 'package:buku_saku_2/configs/components.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/models/db/db_profile.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:buku_saku_2/screens/app/models/providers/dictionary_provider.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:buku_saku_2/screens/app/profile/components/dropdown_field.dart';
import 'package:buku_saku_2/screens/app/profile/components/profile_form_field.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/configs/colors.dart';
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

  late Profile data;

  @override
  void initState() {
    data = context.read<ProfileProvider>().profil;
    for (var item in data.listJenjang!) {
      if (jenjang.isEmpty) {
        jenjang.add(item.jenjang);
      } else if (item.jenjang != jenjang.last) {
        jenjang.add(item.jenjang);
      }
    }

    if (data.id != null) {
      _nameTextController.text = data.nama!;
      _akSaatIniTextController.text = data.akSaatIni!.toStringAsFixed(3);
      for (var item in data.listJenjang!) {
        if (item.id == data.jenjang!.id) {
          selectedJenjang = item.jenjang;
          selectedGolongan = item.golongan;
        }
        if (item.kodeJenjang == data.jenjang!.kodeJenjang) {
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
    return GestureDetector(
      // todo : INI CONTOH ILANGIN FOKUS DARI KEYBOARD
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.only(
            top: AppBar().preferredSize.height +
                MediaQuery.of(context).padding.top,
            bottom: 62 + MediaQuery.of(context).padding.bottom,
          ),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            const SizedBox(height: 20),
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
                  for (var item in data.listJenjang!) {
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
                for (var row in data.listJenjang!) {
                  if (row.jenjang == selectedJenjang && row.golongan == value) {
                    data.jenjang = row;
                  }
                }
              },
            ),
            ProfileFormField(
              title: "Angka Kredit Saat Ini",
              hintText: "Masukkan angka kredit Anda saat ini...",
              controller: _akSaatIniTextController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 40, right: 20, bottom: 0, left: 20),
              child: BlueRoundedButton(
                buttonTitle: 'Simpan',
                onPressed: () {
                  saveData(data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  saveData(Profile data) async {
    if (_formKey.currentState!.validate()) {
      data.nama = _nameTextController.text;
      data.akSaatIni = double.parse(_akSaatIniTextController.text);

      int status = await context.read<ProfileProvider>().saveProfile(data);

      if (status == 1) {
        context.read<DictionaryProvider>().setJenjang = data;
      }

      // nanti status ini dipake utk kasih alert berhasil
      Navigator.pop(context);
    }
  }
}
