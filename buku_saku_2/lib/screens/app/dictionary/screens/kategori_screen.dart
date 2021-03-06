import 'package:flutter/material.dart';
import 'package:buku_saku_2/screens/app/dictionary/screens/unsur_screen.dart';
import 'package:buku_saku_2/screens/app/models/providers/dictionary_provider.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:provider/provider.dart';

class KategoriScreen extends StatelessWidget {
  const KategoriScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Expanded(
            child: TextButton(
              onPressed: () {
                context.read<DictionaryProvider>().setSelectedKategori =
                    "terampil";
                context.read<DictionaryProvider>().setDictionaryList =
                    const UnsurScreen();
                context.read<DictionaryProvider>().setSearchboxExist = true;
              },
              style: AppConstants.kDictBtnStyle,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const <Widget>[
                  Expanded(
                    child: Icon(
                      Icons.cases_rounded,
                      color: AppColors.primary,
                      size: 60,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Prakom Terampil',
                    textAlign: TextAlign.center,
                    style: AppConstants.kCardTitleTextStyle,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: TextButton(
              onPressed: () {
                context.read<DictionaryProvider>().setSelectedKategori = "ahli";
                context.read<DictionaryProvider>().setDictionaryList =
                    const UnsurScreen();
                context.read<DictionaryProvider>().setSearchboxExist = true;
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.info,
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.center,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const <Widget>[
                  Expanded(
                    child: Icon(
                      Icons.cases_rounded,
                      color: AppColors.primary,
                      size: 60,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Prakom Ahli',
                    textAlign: TextAlign.center,
                    style: AppConstants.kCardTitleTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
