import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/screens/app/dictionary/screens/butir_screen.dart';
import 'package:buku_saku_2/screens/app/models/providers/dictionary_provider.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/blue_card_button.dart';
import 'package:provider/provider.dart';

class SubUnsurScreen extends StatelessWidget {
  final Unsur unsur;
  const SubUnsurScreen({Key? key, required this.unsur}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      itemCount: unsur.subunsurList!.length,
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return BlueCardButton(
          code: unsur.subunsurList![index].code,
          title: unsur.subunsurList![index].title,
          subtitle: unsur.subunsurList![index].butirList.length.toString() +
              " Butir Kegiatan",
          onPressed: () {
            context.read<DictionaryProvider>().setDictionaryList = ButirScreen(
              butirList: unsur.subunsurList![index].butirList,
              unsurCode: unsur.code!,
              unsurTitle: unsur.title!,
              subUnsurCode: unsur.subunsurList![index].code,
              subUnsurTitle: unsur.subunsurList![index].title,
            );
          },
        );
      },
    );
  }
}
