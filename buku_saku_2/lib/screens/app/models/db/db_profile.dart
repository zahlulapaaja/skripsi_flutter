import 'dart:async';
import 'package:buku_saku_2/screens/app/models/db/database.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:sqflite/sqflite.dart';

class DbProfile extends DbHelper {
  Future<Profile> getProfile() async {
    final db = await dbInstance;
    Jenjang? jenjang;

    final List<Map<String, dynamic>> maps = await db.query('profil');
    final List<Map<String, dynamic>> maps2 = await db.query('jenjang');

    final List<Jenjang> listJenjang = List.generate(maps2.length, (i) {
      final Jenjang item = Jenjang(
        id: maps2[i]['id'],
        kodeJenjang: maps2[i]['kodeJenjang'],
        jenjang: maps2[i]['jenjang'],
        golongan: maps2[i]['golongan'],
      );
      if (maps.isNotEmpty) {
        if (maps[0]['idJenjang'] == maps2[i]['id']) {
          jenjang = item;
        }
      }
      return item;
    });

    if (maps.isEmpty) {
      return Profile(
        listJenjang: listJenjang,
      );
    } else {
      return Profile(
        id: maps[0]['id'],
        nama: maps[0]['nama'],
        fotoProfil: maps[0]['fotoProfil'],
        jenjang: jenjang,
        akSaatIni: maps[0]['akSaatIni'],
        akUtamaTerkumpul: maps[0]['akUtamaTerkumpul'],
        akPenunjangTerkumpul: maps[0]['akPenunjangTerkumpul'],
        listJenjang: listJenjang,
      );
    }
  }

  Future<List<Jenjang>> getJenjang() async {
    final db = await dbInstance;

    final List<Map<String, dynamic>> maps = await db.query('jenjang');
    return List.generate(maps.length, (i) {
      return Jenjang(
        id: maps[i]['id'],
        kodeJenjang: maps[i]['kodeJenjang'],
        jenjang: maps[i]['jenjang'],
        golongan: maps[i]['golongan'],
      );
    });
  }

  Future<int> saveProfile(Profile data) async {
    final db = await dbInstance;
    int insertedId;

    var profil = await db.query('profil');

    if (profil.isEmpty) {
      insertedId = await db.insert('profil', data.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      insertedId = await db.update('profil', data.toMap(), where: 'id = 1');
    }

    return insertedId;
  }
}
