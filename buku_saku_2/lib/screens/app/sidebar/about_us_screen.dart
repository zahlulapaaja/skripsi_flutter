import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  static const id = 'about_us_screen';
  const AboutUsScreen({Key? key}) : super(key: key);
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
              title: 'Tentang Kami',
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

  Widget getMainListViewUI(context) {
    return Container(
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.asset('assets/icons/about_us.png'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text(
              "Buku Saku Prakom adalah aplikasi untuk memudahkan para pranata komputer di Indonesia dalam mencatat dan memantau angka kredit. Aplikasi ini dibangun oleh Zahlul Fuadi, lulusan Politeknik Statistika Tahun 2022. (bla bla bla)",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppConstants.fontName,
                color: AppColors.black,
                fontSize: AppConstants.kNormalFontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Lihat ',
              style: TextStyle(
                fontFamily: AppConstants.fontName,
                color: AppColors.black,
                fontSize: AppConstants.kSmallFontSize,
              ),
              children: [
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Data Profil'),
                          content: const Text(
                              'Masukkan data profil untuk memulai aplikasi ini'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(context, 'Lanjutkan'),
                              child: const Text('Lanjutkan'),
                            ),
                          ],
                        ),
                      );
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
