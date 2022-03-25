import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/dictionary/screens/butir_screen.dart';
import 'package:buku_saku_2/screens/app/dictionary/screens/unsur_screen.dart';
import 'package:buku_saku_2/screens/app/models/dictionary_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DictSearchBox extends StatelessWidget {
  const DictSearchBox(
      {Key? key, this.codes, this.titles, this.subtitles, this.detailButir})
      : super(key: key);

  final List<String>? codes;
  final List<String>? titles;
  final List<String>? subtitles;
  final List<dynamic>? detailButir;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1.5, color: AppColors.lightBlack),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 10,
            color: AppColors.primary.withOpacity(0.25),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              onChanged: (value) {
                if (value == '') {
                  context.read<DictionaryProvider>().setDictionaryList =
                      UnsurScreen();
                } else {
                  context.read<DictionaryProvider>().setQuery = value;
                  List<ButirKegiatan> results =
                      context.read<DictionaryProvider>().matchedButir;
                  context.read<DictionaryProvider>().setDictionaryList =
                      ButirScreen(butirList: results);
                }
              },
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(
                hintText: "Masukkan kata kunci...",
                hintStyle: TextStyle(
                  fontFamily: AppConstants.fontName,
                  color: AppColors.grey,
                  fontSize: AppConstants.kSmallFontSize,
                  fontWeight: FontWeight.normal,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              style: AppConstants.kTextFieldTextStyle,
            ),
          ),
          // IconButton(
          //   icon: const Icon(Icons.close),
          //   onPressed: () {
          //     // TODO : disini nanti logika untuk hapus isi searchbox
          //     // kalo diklik nanti tulisannya ilang, harusnya, masalahnya ini stateless
          //   },
          // ),
          // const SizedBox(width: 10),
          SvgPicture.asset("assets/icons/search.svg"),
        ],
      ),
    );
  }
}
