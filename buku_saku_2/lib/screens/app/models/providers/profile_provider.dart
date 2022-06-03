import 'package:buku_saku_2/screens/app/models/db/db_profile.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider with ChangeNotifier {
  Profile? _profile;
  List<Jenjang>? _jenjang;
  var dbHelper = DbProfile();

  Profile get profil => _profile!;

  Future<Profile> get getProfileData async {
    _profile = await dbHelper.getProfile();
    return _profile!;
  }

  Future<List<Jenjang>> get getJenjang async {
    _jenjang = await dbHelper.getJenjang();
    return _jenjang!;
  }

  Future<int> saveProfile(Profile data) async {
    int res = await dbHelper.saveProfile(data);
    notifyListeners();
    return res;
  }
}
