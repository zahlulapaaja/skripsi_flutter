import 'dart:convert';

import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/models/db/db_profile.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:buku_saku_2/screens/app/models/target_angka_kredit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ProfileProvider with ChangeNotifier {
  Profile _profile = Profile();
  List<Jenjang>? _jenjang;
  String? _alert;
  String? _pelaksana;
  List<TargetAngkaKredit> _jsonData = [];
  TargetAngkaKredit _pangkatSaatIni = TargetAngkaKredit();
  var dbHelper = DbProfile();

  Profile get profil => _profile;
  List<Jenjang> get listJenjang => _jenjang!;
  TargetAngkaKredit get pangkatSaatIni => _pangkatSaatIni;

  set setSelectedButir(ButirKegiatan butir) {
    _pelaksana = butir.pelaksana;
    notifyListeners();
  }

  String? get getAlert {
    int? kodeJenjang;
    for (var item in listJenjang) {
      if (_pelaksana == "Semua Jenjang" || _pelaksana == item.jenjang) {
        kodeJenjang = item.kodeJenjang;
      }
    }
    if (_profile.jenjang!.kodeJenjang.abs() - kodeJenjang! == -1) {
      _alert = "Butir ini hanya memperoleh 80% angka kredit penuh!!";
    }
    return _alert;
  }

  Future<Profile> get getProfileData async {
    _profile = await dbHelper.getProfile();
    _jenjang = _profile.listJenjang;
    if (_profile.id != null) await getTargetAK();
    notifyListeners();

    return _profile;
  }

  Future<int> saveProfile(Profile data) async {
    int res = await dbHelper.saveProfile(data);
    if (res == 1) {
      _profile = await dbHelper.getProfile();
    }
    notifyListeners();
    return res;
  }

  Future<void> getTargetAK() async {
    final jsonData =
        await rootBundle.loadString("assets/jsonfile/ak_naik_pangkat.json");

    List<dynamic> list = json.decode(jsonData) as List<dynamic>;
    _jsonData = list.map((e) => TargetAngkaKredit.fromJson(e)).toList();

    for (var i = 0; i < _jsonData.length; i++) {
      if (_profile.jenjang!.jenjang == _jsonData[i].jenjang) {
        if (_profile.jenjang!.golongan == _jsonData[i].golongan) {
          if (_jsonData[i].pangkatPuncak!) {
            _jsonData[i].jenjangSelanjutnya = _jsonData[i + 1].jenjang;
          } else {
            _jsonData[i].golonganSelanjutnya = _jsonData[i + 1].golongan;
            if (_jsonData[i + 1].pangkatPuncak!) {
              _jsonData[i].akNaikJenjang = _jsonData[i + 1].akNaikPangkat;
              _jsonData[i].jenjangSelanjutnya = _jsonData[i + 2].jenjang;
            } else {
              _jsonData[i].akNaikJenjang = _jsonData[i + 2].akNaikPangkat;
              _jsonData[i].jenjangSelanjutnya = _jsonData[i + 3].jenjang;
            }
          }
          _pangkatSaatIni = _jsonData[i];
        }
      }
    }
  }
}
