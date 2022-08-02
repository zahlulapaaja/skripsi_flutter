import 'dart:io';

import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:buku_saku_2/screens/app/profile/components/setting_menu_button.dart';
import 'package:buku_saku_2/screens/app/profile/edit_profile_screen.dart';
import 'package:buku_saku_2/screens/app/sidebar/about_us_screen.dart';
import 'package:buku_saku_2/screens/app/sidebar/export_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  static const id = 'setting_screen';
  const SettingScreen({Key? key}) : super(key: key);

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
              title: 'Setelan',
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
    Profile profil = context.watch<ProfileProvider>().profil;
    return ListView(
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      scrollDirection: Axis.vertical,
      children: <Widget>[
        const SizedBox(height: 20),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, EditProfileScreen.id);
          },
          child: SizedBox(
            height: 80,
            child: Row(
              children: <Widget>[
                Container(
                  height: 75,
                  width: 75,
                  margin: const EdgeInsets.only(right: 14),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                    child: (profil.fotoProfil == null)
                        ? Image.asset(
                            "assets/icons/profile.png",
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(profil.fotoProfil!),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        profil.nama!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppConstants.kNormalTitleTextStyle,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        profil.jenjang!.jenjang.replaceRange(0, 16, "Prakom"),
                        textAlign: TextAlign.left,
                        style: AppConstants.kCardBodyTextStyle,
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.edit,
                  color: AppColors.black,
                  size: 30,
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ),
        const Divider(color: AppColors.lightGrey),
        // SettingMenuButton(
        //   icon: Icons.settings,
        //   title: 'Setelan',
        //   subtitle: 'Tema, Riwayat, Dll...',
        //   onPressed: () {},
        // ),
        SettingMenuButton(
          icon: Icons.delete,
          color: AppColors.alert,
          title: 'Hapus Semua Catatan',
          subtitle: 'Hapus semua catatan Anda',
          onPressed: () async {
            var result = await showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Hapus Semua Catatan'),
                content:
                    const Text('Anda yakin ingin menghapus semua catatan ?'),
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

            if (result == 'Ya') {
              context.read<NotesProvider>().deleteAllNotes();
            }
          },
        ),
        SettingMenuButton(
          icon: Icons.file_download,
          title: 'Ekspor Catatan',
          subtitle: 'Simpan catatan dalam format excel',
          onPressed: () {
            Navigator.pushNamed(context, ExportNotesScreen.id);
          },
        ),
        SettingMenuButton(
          icon: Icons.info,
          title: 'Tentang',
          subtitle: 'Informasi mengenai aplikasi',
          onPressed: () {
            Navigator.pushNamed(context, AboutUsScreen.id);
          },
        ),
      ],
    );
  }
}
