import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/models/db/db_profile.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
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
  final Profile? initialData;
  EditProfileScreen({Key? key, this.initialData}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  //rapiin lagi bawah bawah ni
  final _formKey = GlobalKey<FormState>();
  var dbHelper = DbProfile();
  final _nameTextController = TextEditingController();
  final _akUtamaTextController = TextEditingController();
  final _akPenunjangTextController = TextEditingController();

  List<String> golongan = [];
  String? selectedJenjang;
  String? selectedGolongan;

  Profile data = Profile();
  List<Jenjang> listJenjang = [];
  List<String> jenjang = [];

  @override
  void initState() {
    // TODO: implement initState
    if (widget.initialData != null) {
      _nameTextController.text = widget.initialData!.nama!;
      _akUtamaTextController.text =
          widget.initialData!.akUtamaTerkumpul.toString();
      _akPenunjangTextController.text =
          widget.initialData!.akPenunjangTerkumpul.toString();
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
      child: FutureBuilder(
          future: context.read<ProfileProvider>().getProfileData,
          builder: (context, AsyncSnapshot<Profile> snapshot) {
            if (snapshot.data!.id != null) {
              data = snapshot.data!;
              listJenjang = data.listJenjang!;
              jenjang = List.generate(listJenjang.length, (i) {
                if (listJenjang[i].id == data.idJenjang) {
                  selectedJenjang = listJenjang[i].jenjang;
                  selectedGolongan = listJenjang[i].golongan;
                }
                return listJenjang[i].jenjang;
              });
            }

            return ListView(
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
                  data: jenjang,
                  initialData: selectedJenjang,
                  onChanged: (value) {
                    setState(() {
                      selectedJenjang = value;
                      golongan = [];
                      for (var row in listJenjang) {
                        if (row.jenjang == value) {
                          golongan.add(row.golongan);
                        }
                      }
                    });
                  },
                ),
                DropdownField(
                  data: golongan,
                  initialData: selectedGolongan,
                  onChanged: (value) {
                    for (var row in listJenjang) {
                      if (row.jenjang == selectedJenjang) {
                        if (row.golongan == value) {
                          setState(() {
                            data.idJenjang = row.id;
                          });
                        }
                      }
                    }
                  },
                ),
                ProfileFormField(
                  headingText: "Angka Kredit Utama Saat Ini",
                  hintText: "Masukkan nama lengkap anda...",
                  suffixIcon: const SizedBox(),
                  obsecureText: false,
                  maxLines: 1,
                  controller: _akUtamaTextController,
                  textInputAction: TextInputAction.done,
                  textInputType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
                ProfileFormField(
                  headingText: "Angka Kredit Pengembangan Profesi Saat Ini",
                  hintText: "Masukkan nama lengkap anda...",
                  suffixIcon: const SizedBox(),
                  obsecureText: false,
                  maxLines: 1,
                  controller: _akPenunjangTextController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                ),
                ElevatedButton(
                  onPressed: () {
                    saveData(data);
                  },
                  child: const Text('Gass'),
                )
              ],
            );
          }),
    );
  }

  saveData(Profile data) async {
    if (_formKey.currentState!.validate()) {
      data.nama = _nameTextController.text;
      data.akUtamaTerkumpul = double.parse(_akUtamaTextController.text);
      data.akPenunjangTerkumpul = double.parse(_akPenunjangTextController.text);

      int status = await context.read<ProfileProvider>().saveProfile(data);
      // nanti status ini dipake utk kasih alert berhasil
      Navigator.pop(context);
    }
  }
}
