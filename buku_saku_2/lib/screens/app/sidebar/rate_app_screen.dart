import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:flutter/material.dart';

class RateAppScreen extends StatelessWidget {
  static const id = 'rate_app_screen';
  const RateAppScreen({Key? key}) : super(key: key);
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
              title: 'Rate Aplikasi',
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
            child: Image.asset('assets/icons/rate_app.png'),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              "Bantu aplikasi ini menjadi lebih baik. Beri masukan dan dukungan demi aplikasi yang lebih baik.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppConstants.fontName,
                color: AppColors.primaryDark,
                fontSize: AppConstants.kNormalFontSize - 1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              // Masih jadi pertanyaan ini diarahin kemana
            },
            label: const Text('Berikan Peringkat'),
            icon: const Icon(Icons.star_rounded),
          ),
        ],
      ),
    );
  }
}
