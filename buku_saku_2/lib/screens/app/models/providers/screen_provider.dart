import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';

class ScreenProvider with ChangeNotifier {
  Widget _tabBody = Container(
    color: AppColors.offWhite,
    child: const Center(child: CircularProgressIndicator()),
  );

  Widget get tabBody => _tabBody;

  set setTabBody(Widget widget) {
    _tabBody = widget;
    notifyListeners();
  }
}
