import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/models/db/db_profile.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier {
  Profile _profile = Profile();
  List<Jenjang>? _jenjang;
  String? _alert;
  String? _pelaksana;
  var dbHelper = DbProfile();

  Profile get profil => _profile;
  List<Jenjang> get listJenjang => _jenjang!;

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
}
