import 'package:buku_saku_2/screens/app/dictionary/components/dict_searchbox.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/models/providers/dictionary_provider.dart';
import 'package:provider/provider.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.offWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            ListView(
                padding: EdgeInsets.only(
                  top: AppBar().preferredSize.height +
                      MediaQuery.of(context).padding.top,
                  bottom: 62 + MediaQuery.of(context).padding.bottom,
                ),
                scrollDirection: Axis.vertical,
                children: [
                  if (context.watch<DictionaryProvider>().searchboxExist)
                    const DictSearchBox(),
                  context.watch<DictionaryProvider>().dictionaryList,
                ]),
            const AppBarUI(title: 'Kamus'),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }
}
