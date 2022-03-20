import 'package:flutter/material.dart';
import 'package:buku_saku_2/screens/app/dictionary/screens/unsur_screen.dart';

class DictionaryProvider with ChangeNotifier {
  String _selectedUnsurCode = '';
  String _selectedUnsur = '';
  String _selectedSubUnsurCode = '';
  String _selectedSubUnsur = '';
  String _query = '';

  List<Map<String, dynamic>> _allButir = [];
  List<Map<String, dynamic>> _matchedButir = [];
  Widget _dictionaryList = const UnsurScreen();

  String get selectedUnsurCode => _selectedUnsurCode;
  String get selectedUnsur => _selectedUnsur;
  String get selectedSubUnsurCode => _selectedSubUnsurCode;
  String get selectedSubUnsur => _selectedSubUnsur;
  Widget get dictionaryList => _dictionaryList;
  List<Map<String, dynamic>> get matchedButir => _matchedButir;

  set setQuery(String query) {
    _matchedButir = [];

    _query = query.toLowerCase();
    for (var butir in _allButir) {
      String judul = butir['judul'].toString().toLowerCase();
      if (judul.contains(_query)) {
        _matchedButir.add(butir);
      }
    }
    notifyListeners();
  }

  set setDictionaryList(Widget widget) {
    _dictionaryList = widget;
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

  set setAllButir(List<Map<String, dynamic>> data) {
    _allButir = data;
  }
}
