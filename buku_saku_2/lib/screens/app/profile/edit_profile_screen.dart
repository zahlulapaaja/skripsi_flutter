import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/models/db/db_profile.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:buku_saku_2/screens/app/models/providers/dictionary_provider.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:buku_saku_2/screens/app/profile/components/dropdown_field.dart';
import 'package:buku_saku_2/screens/app/profile/components/form_field.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  static const id = 'edit_profile_screen';
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  //rapiin lagi bawah bawah ni
  final _formKey = GlobalKey<FormState>();
  var dbHelper = DbProfile();
  final _nameTextController = TextEditingController();
  final _akSaatIniTextController = TextEditingController();

  List<String> golongan = [];
  String? selectedJenjang;
  String? selectedGolongan;

  Profile data = Profile();
  List<String> jenjang = [];

  @override
  void initState() {
    data = context.read<ProfileProvider>().profil;
    if (data.id != null) {
      _nameTextController.text = data.nama!;
      _akSaatIniTextController.text = data.akSaatIni!.toStringAsFixed(3);
      for (var i = 0; i < data.listJenjang!.length; i++) {
        Jenjang item = data.listJenjang![i];
        if (item.id == data.jenjang!.id) {
          selectedJenjang = item.jenjang;
          selectedGolongan = item.golongan;
        }
        if (i == 0) {
          jenjang.add(item.jenjang);
        } else if (item.jenjang != data.listJenjang![i - 1].jenjang) {
          jenjang.add(item.jenjang);
        }
        if (item.kodeJenjang == data.jenjang!.kodeJenjang) {
          golongan.add(item.golongan);
        }
      }
    } else {
      for (var i = 0; i < data.listJenjang!.length; i++) {
        Jenjang item = data.listJenjang![i];
        if (i == 0) {
          jenjang.add(item.jenjang);
        } else if (item.jenjang != data.listJenjang![i - 1].jenjang) {
          jenjang.add(item.jenjang);
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

  Widget getMainListViewUI(BuildContext context) {
    return Form(
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
            headingText: "Full Name",
            hintText: "Masukkan nama lengkap anda...",
            suffixIcon: const SizedBox(),
            obsecureText: false,
            maxLines: 1,
            controller: _nameTextController,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.emailAddress,
          ),
          DropdownField(
            title: "Jenjang",
            data: jenjang,
            initialData: selectedJenjang,
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
            onChanged: (value) {
              for (var row in data.listJenjang!) {
                if (row.jenjang == selectedJenjang && row.golongan == value) {
                  data.jenjang = row;
                }
              }
            },
          ),
          ProfileFormField(
            headingText: "Angka Kredit Saat Ini",
            hintText: "Masukkan nama lengkap anda...",
            suffixIcon: const SizedBox(),
            obsecureText: false,
            maxLines: 1,
            controller: _akSaatIniTextController,
            textInputAction: TextInputAction.done,
            textInputType: const TextInputType.numberWithOptions(decimal: true),
          ),
          ElevatedButton(
            onPressed: () {
              saveData(data);
            },
            child: const Text('Gass'),
          )
        ],
      ),
    );
  }

  saveData(Profile data) async {
    if (_formKey.currentState!.validate()) {
      data.nama = _nameTextController.text;
      data.akSaatIni = double.parse(_akSaatIniTextController.text);

      if (data.id == null) {
        data.akUtamaTerkumpul = 0;
        data.akPenunjangTerkumpul = 0;
      }

      int status = await context.read<ProfileProvider>().saveProfile(data);

      if (status == 1) {
        context.read<DictionaryProvider>().setJenjang = data;
      }
      // nanti status ini dipake utk kasih alert berhasil
      Navigator.pop(context);
    }
  }
}
