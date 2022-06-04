import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:buku_saku_2/screens/app/profile/components/setting_menu_button.dart';
import 'package:buku_saku_2/screens/app/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            // edit lebih rapi lagi
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditProfileScreen(),
              ),
            );
          },
          child: SizedBox(
            height: 80,
            child: Row(
              children: <Widget>[
                Container(
                  width: 75,
                  padding: const EdgeInsets.all(4.0),
                  child: const Icon(
                    FontAwesomeIcons.userCircle,
                    color: AppColors.black,
                    size: 40,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'title',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppConstants.kCardTitleTextStyle,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'subtitle',
                        textAlign: TextAlign.left,
                        style: AppConstants.kCardBodyTextStyle,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.edit,
                  color: AppColors.black,
                  size: 30,
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
        Divider(color: Colors.black),
        SettingMenuButton(
          icon: Icons.settings,
          title: 'Setelan',
          subtitle: 'Tema, Riwayat, Dll...',
          onPressed: () {},
        ),
        SettingMenuButton(
          icon: Icons.history,
          title: 'Histori',
          subtitle: 'Catatan yang telah selesai',
          onPressed: () {},
        ),
        SettingMenuButton(
          icon: Icons.info,
          title: 'Tentang',
          subtitle: 'Aplikasi, Pengembang, Dll...',
          onPressed: () {},
        ),
      ],
    );
  }
}
