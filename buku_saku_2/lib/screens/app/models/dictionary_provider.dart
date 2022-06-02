import 'dart:convert';

import 'package:buku_saku_2/screens/app/dictionary/screens/jenjang_screen.dart';
import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DictionaryProvider with ChangeNotifier {
  String _query = '';
  List<Unsur> _jsonData = [];
  List<ButirKegiatan> _allButir = [];
  List<ButirKegiatan> _matchedButir = [];
  Widget _dictionaryList = const JenjangScreen();

  Widget get dictionaryList => _dictionaryList;
  List<Unsur> get jsonData => _jsonData;
  List<ButirKegiatan> get allButir => _allButir;
  List<ButirKegiatan> get matchedButir => _matchedButir;

  String _jenjang = '';
  List<String> disableButir1 = [];
  List<String> disableButir2 = [];
  // ketika pengaturan jenjang diganti, disable nya harus dikosongin nanti

  List<String> get disableButir =>
      List.from(disableButir1)..addAll(disableButir2);

  Future<List<Unsur>> get readJsonData async {
    dynamic jsonData;
    if (_jenjang.toLowerCase().contains('terampil')) {
      jsonData = await rootBundle
          .loadString('assets/jsonfile/data_juknis_terampil.json');
    } else if (_jenjang.toLowerCase().contains('ahli')) {
      jsonData =
          await rootBundle.loadString('assets/jsonfile/data_juknis_ahli.json');
    } else {
      print('belom ada jenjang');
    }

    final jsonDataAddition = await rootBundle
        .loadString('assets/jsonfile/data_juknis_tambahan.json');

    List<dynamic> list = json.decode(jsonData) as List<dynamic>;
    list += json.decode(jsonDataAddition) as List<dynamic>;
    _jsonData = list.map((e) => Unsur.fromJson(e)).toList();

    return _jsonData;
  }

  set setJenjang(String jenjang) {
    _jenjang = jenjang;
  }

  set setDisableButir2(List<Note> notes) {
    disableButir2 = [];

    for (Note note in notes) {
      disableButir2.add(note.judul!);
    }
  }

  set storeData(List<Unsur> listUnsur) {
    // store data ini cma dipanggil saat masuk form baru
    List<ButirKegiatan> butirList = [];
    disableButir1 = [];
    for (var unsur in listUnsur) {
      for (var subunsur in unsur.subunsurList!) {
        for (var butir in subunsur.butirList) {
          butir.unsurCode = unsur.code;
          butir.unsurTitle = unsur.title;
          butir.subUnsurCode = subunsur.code;
          butir.subUnsurTitle = subunsur.title;
          butirList.add(butir);

          //nanti ini ganti
          if (butir.pelaksana == 'Pranata Komputer Ahli Madya') {
            disableButir1.add(butir.judul);
          }
        }
      }
    }
    _allButir = butirList;
  }

  set setQuery(String query) {
    _matchedButir = [];

    _query = query.toLowerCase();
    for (var butir in _allButir) {
      String judul = butir.judul.trim().toLowerCase();
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
