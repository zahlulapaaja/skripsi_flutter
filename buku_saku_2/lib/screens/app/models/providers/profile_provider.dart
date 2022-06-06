import 'package:buku_saku_2/screens/app/models/db/db_profile.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier {
  Profile _profile = Profile();
  List<Jenjang>? _jenjang;
  var dbHelper = DbProfile();

  Profile get profil => _profile;
  List<Jenjang> get listJenjang => _jenjang!;

  Future<Profile> get getProfileData async {
    _profile = await dbHelper.getProfile();
    _jenjang = _profile.listJenjang;

    return _profile;
  }

  // Future<List<Jenjang>> get getJenjang async {
  //   _jenjang = await dbHelper.getJenjang();
  //   return _jenjang!;
  // }

  Future<int> saveProfile(Profile data) async {
    int res = await dbHelper.saveProfile(data);
    if (res == 1) {
      _profile = await dbHelper.getProfile();
    }
    notifyListeners();
    return res;
  }
}
