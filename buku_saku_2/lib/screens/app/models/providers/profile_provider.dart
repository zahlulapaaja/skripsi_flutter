import 'package:buku_saku_2/screens/app/models/db/db_profile.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/db/database.dart';

class ProfileProvider with ChangeNotifier {
  Profile? _profile;
  List<dynamic>? _jenjang;
  var dbHelper = DbProfile();

  Future<Profile> get getProfileData async {
    _profile = await dbHelper.getProfile();
    return _profile!;
  }

  Future<List<dynamic>> get getJenjang async {
    _jenjang = await dbHelper.getJenjang();
    return _jenjang!;
  }

  set setProfile(Profile data) {
    print(_profile?.name);
    _profile = data;
    notifyListeners();
  }
}
