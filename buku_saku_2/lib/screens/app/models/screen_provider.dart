import 'package:buku_saku_2/screens/app/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:buku_saku_2/configs/colors.dart';

class ScreenProvider with ChangeNotifier {
  String _selectedUnsurCode = '';
  String _selectedUnsur = '';
  String _selectedSubUnsurCode = '';
  String _selectedSubUnsur = '';
  Widget _tabBody = Container(
    color: AppColors.offWhite,
    child: const Center(child: CircularProgressIndicator()),
  );

  Widget get tabBody => _tabBody;
  String get selectedUnsurCode => _selectedUnsurCode;
  String get selectedUnsur => _selectedUnsur;
  String get selectedSubUnsurCode => _selectedSubUnsurCode;
  String get selectedSubUnsur => _selectedSubUnsur;

  set setTabBody(Widget widget) {
    _tabBody = widget;
    notifyListeners();
  }

  set setUnsurCode(String text) {
    _selectedUnsurCode = text;
    notifyListeners();
  }

  set setUnsur(String text) {
    _selectedUnsur = text;
    notifyListeners();
  }

  set setSubUnsurCode(String text) {
    _selectedSubUnsurCode = text;
    notifyListeners();
  }

  set setSubUnsur(String text) {
    _selectedSubUnsur = text;
    notifyListeners();
  }
}
