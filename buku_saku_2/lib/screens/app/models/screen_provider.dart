import 'dart:convert';

import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:flutter/services.dart';

class ScreenProvider with ChangeNotifier {
  Widget _tabBody = Container(
    color: AppColors.offWhite,
    child: const Center(child: CircularProgressIndicator()),
  );

  Future<List<Unsur>> get readJsonData async {
    final jsonData =
        await rootBundle.loadString('assets/jsonfile/data_juknis_trial.json');
    final list = json.decode(jsonData) as List<dynamic>;

    return list.map((e) => Unsur.fromJson(e)).toList();
  }

  Widget get tabBody => _tabBody;

  set setTabBody(Widget widget) {
    _tabBody = widget;
    notifyListeners();
  }
}
