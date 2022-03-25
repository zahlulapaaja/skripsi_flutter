import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/screens/app/dictionary/screens/unsur_screen.dart';

class DictionaryProvider with ChangeNotifier {
  String _query = '';
  List<Unsur> _jsonData = [];
  List<ButirKegiatan> _allButir = [];
  List<ButirKegiatan> _matchedButir = [];
  Widget _dictionaryList = UnsurScreen();

  Widget get dictionaryList => _dictionaryList;
  List<Unsur> get jsonData => _jsonData;
  List<ButirKegiatan> get allButir => _allButir;
  List<ButirKegiatan> get matchedButir => _matchedButir;

  set storeData(List<Unsur> listUnsur) {
    _jsonData = listUnsur;
    List<ButirKegiatan> butirList = [];
    for (var unsur in listUnsur) {
      for (var subunsur in unsur.subunsurList!) {
        for (var butir in subunsur.butirList) {
          butir.unsurCode = unsur.code;
          butir.unsurTitle = unsur.title;
          butir.subUnsurCode = subunsur.code;
          butir.subUnsurTitle = subunsur.title;
          butirList.add(butir);
        }
      }
    }
    _allButir = butirList;
  }

  set setQuery(String query) {
    _matchedButir = [];

    _query = query.toLowerCase();
    for (var butir in _allButir) {
      String judul = butir.judul.toLowerCase();
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

  set setAllButir(List<ButirKegiatan> data) {
    _allButir = data;
  }
}
