import 'package:buku_saku_2/configs/components.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/models/db/database.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:buku_saku_2/screens/app/profile/components/dropdown_field.dart';
import 'package:buku_saku_2/screens/app/profile/components/setting_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  static const id = 'edit_profile_screen';
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  var dbHelper = DbHelper();
  final _textController = TextEditingController();

  // String? name;
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
          FormFieldTemplate(
            headingText: "Full Name",
            hintText: "Masukkan nama lengkap anda...",
            suffixIcon: const SizedBox(),
            obsecureText: false,
            maxLines: 1,
            controller: _textController,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.emailAddress,
          ),
          Divider(color: Colors.black),
          FormFieldTemplate(
            headingText: "Full Name",
            hintText: "Masukkan nama lengkap anda...",
            suffixIcon: const SizedBox(),
            obsecureText: false,
            maxLines: 1,
            controller: _textController,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.emailAddress,
          ),
          FutureBuilder(
              future: context.watch<ProfileProvider>().getJenjang,
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                print(snapshot.data![0]['id']);
                // nanti ganti name ini jadi jenjang aja (termasuk di db nya)
                return DropdownField(
                  data: List.generate(
                      snapshot.data!.length, (i) => snapshot.data![i]['name']),
                  onChanged: (value) {
                    print('changed');
                  },
                );
              }),
          SettingMenuButton(
            icon: Icons.settings,
            title: 'Setelan',
            subtitle: 'Tema, Riwayat, Dll...',
            onPressed: () {},
          ),
          ElevatedButton(
            onPressed: () => saveData(_textController.text),
            child: const Text('Gass'),
          )
        ],
      ),
    );
  }

  saveData(String data) async {
    if (_formKey.currentState!.validate()) {
      // final newNote = selectedNote;

      // (widget.note?.id != null)
      //     ? noteProvider.updateNote(newNote)
      //     : noteProvider.addNewNote(newNote);
      print(data);
      // if (dbHelper.getNameTest() == null || dbHelper.getNameTest() == '') {
      // await dbHelper.saveProfileTest(data);
      //   print(dbHelper.getNameTest());
      // } else {
      // TODO : deteksi ada data atau tidak, logika di atas kurang pas
      await dbHelper.updateNameTest(data);
      // }

      Navigator.pop(context);
    }
  }
}
