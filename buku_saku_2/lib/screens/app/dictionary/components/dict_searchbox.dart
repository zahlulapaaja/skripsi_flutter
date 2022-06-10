import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/dictionary/screens/butir_screen.dart';
import 'package:buku_saku_2/screens/app/dictionary/screens/unsur_screen.dart';
import 'package:buku_saku_2/screens/app/models/providers/dictionary_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DictSearchBox extends StatelessWidget {
  DictSearchBox(
      {Key? key, this.codes, this.titles, this.subtitles, this.detailButir})
      : super(key: key);

  final List<String>? codes;
  final List<String>? titles;
  final List<String>? subtitles;
  final List<dynamic>? detailButir;
  TextEditingController controller = TextEditingController();

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
              controller: controller,
              onChanged: (value) {
                if (value == '') {
                  context.read<DictionaryProvider>().setDictionaryList =
                      const UnsurScreen();
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
              decoration: AppConstants.kSearchboxDecoration,
              style: AppConstants.kTextFieldTextStyle,
            ),
          ),
          if (context.watch<DictionaryProvider>().isQueryExist)
            IconButton(
              onPressed: () {
                controller.text = '';
                context.read<DictionaryProvider>().setQuery = '';
              },
              icon: const Icon(
                Icons.close,
                size: 20,
              ),
            ),
          SvgPicture.asset("assets/icons/search.svg"),
        ],
      ),
    );
  }
}
