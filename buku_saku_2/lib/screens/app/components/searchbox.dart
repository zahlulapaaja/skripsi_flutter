import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/models/dictionary_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchBox extends StatelessWidget {
  SearchBox({Key? key}) : super(key: key);

  List<String>? codes;
  List<String>? titles;
  List<String>? subtitles;
  List<dynamic>? detailButir;

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
                // ini searchbox di notes
                context.read<DictionaryProvider>().setQuery = value;
              },
              autocorrect: false,
              enableSuggestions: false,
              decoration: AppConstants.kSearchboxDecoration,
              style: AppConstants.kTextFieldTextStyle,
            ),
          ),
          SvgPicture.asset("assets/icons/search.svg"),
        ],
      ),
    );
  }

  // Widget getMainListViewUI(BuildContext context, List<dynamic> data) {
  //   return ListView.builder(
  //     padding: const EdgeInsets.symmetric(horizontal: 14.0),
  //     itemCount: data!.length,
  //     physics: const ScrollPhysics(),
  //     shrinkWrap: true,
  //     itemBuilder: (context, index) {
  //       // getData(data);
  //       return BlueCardButton(
  //         code: codes![index],
  //         title: titles![index],
  //         subtitle: subtitles![index],
  //         onPressed: () {
  //           context.read<ScreenProvider>().setUnsurCode = codes![index];
  //           context.read<ScreenProvider>().setUnsur = titles![index];
  //           // context.read<ScreenProvider>().setTabBody =
  //           //     SubUnsurListScreen(subUnsur: subUnsur![index]);
  //         },
  //       );
  //     },
  //   );
  // }
}
