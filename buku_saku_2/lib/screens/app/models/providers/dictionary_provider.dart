import 'dart:convert';

import 'package:buku_saku_2/screens/app/dictionary/screens/jenjang_screen.dart';
import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DictionaryProvider with ChangeNotifier {
  final jsonPrakomAhli = 'assets/jsonfile/data_juknis_ahli.json';
  final jsonPrakomTerampil = 'assets/jsonfile/data_juknis_terampil.json';
  final jsonTambahan = 'assets/jsonfile/data_juknis_tambahan.json';

  String _query = '';
  List<Unsur> _jsonData = [];
  List<ButirKegiatan> _allButir = [];
  List<ButirKegiatan> _matchedButir = [];
  Widget _dictionaryList = const JenjangScreen();

  Widget get dictionaryList => _dictionaryList;
  List<Unsur> get jsonData => _jsonData;
  List<ButirKegiatan> get allButir => _allButir;
  List<ButirKegiatan> get matchedButir => _matchedButir;

  Jenjang? _jenjang;
  List<Jenjang>? _listJenjang;
  List<String> disableButir1 = [];
  List<String> disableButir2 = [];
  // ketika pengaturan jenjang diganti, disable nya harus dikosongin nanti

  List<String> get disableButir =>
      List.from(disableButir1)..addAll(disableButir2);

  Future<List<Unsur>> get readJsonData async {
    dynamic jsonData;

    if (_jenjang!.jenjang.toLowerCase().contains('ahli')) {
      jsonData = await rootBundle.loadString(jsonPrakomAhli);
    } else {
      jsonData = await rootBundle.loadString(jsonPrakomTerampil);
    }

    final jsonDataAddition = await rootBundle.loadString(jsonTambahan);

    List<dynamic> list = json.decode(jsonData) as List<dynamic>;
    list += json.decode(jsonDataAddition) as List<dynamic>;
    _jsonData = list.map((e) => Unsur.fromJson(e)).toList();

    return _jsonData;
  }

  set setJenjang(Profile profil) {
    _jenjang = profil.jenjang;
    _listJenjang = profil.listJenjang;
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
    int? kodeJenjang;
    disableButir1 = [];
    for (var unsur in listUnsur) {
      for (var subunsur in unsur.subunsurList!) {
        for (var butir in subunsur.butirList) {
          butir.unsurCode = unsur.code;
          butir.unsurTitle = unsur.title;
          butir.subUnsurCode = subunsur.code;
          butir.subUnsurTitle = subunsur.title;
          butirList.add(butir);

          for (var item in _listJenjang!) {
            if (butir.pelaksana == item.jenjang) {
              kodeJenjang = item.kodeJenjang;
            } else if (butir.pelaksana == "Semua Jenjang") {
              // disamain agar diterima di semua jenjang dan ga null jadinya
              kodeJenjang = _jenjang!.kodeJenjang;
            }
          }

          if ((kodeJenjang! - _jenjang!.kodeJenjang).abs() >= 2) {
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
