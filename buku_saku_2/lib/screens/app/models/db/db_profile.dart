import 'dart:async';
import 'package:buku_saku_2/screens/app/models/db/database.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:sqflite/sqflite.dart';

class DbProfile extends DbHelper {
  Future<Profile> getProfile() async {
    final db = await dbInstance;

    final List<Map<String, dynamic>> maps = await db.query('profil');

    if (maps.isEmpty) {
      return Profile();
    } else {
      return Profile(
        id: maps[0]['id'],
        nama: maps[0]['nama'],
        fotoProfil: maps[0]['fotoProfil'],
      );
    }
  }

  Future<List<dynamic>> getJenjang() async {
    final db = await dbInstance;

    final List<Map<String, dynamic>> maps = await db.query('jenjang');
    return maps;
  }

  Future<List<dynamic>> getGolonga() async {
    final db = await dbInstance;

    final List<Map<String, dynamic>> maps = await db.query('golongan');
    return maps;
  }

  Future<void> saveProfileTest(String nama) async {
    final db = await dbInstance;

    final insertedId = await db.insert(
        'profil',
        {
          'nam': nama,
          'fotoProfil': 'kosong',
          'jenjang': 'Prakom Aja',
          'ak_now': 14.9,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateNameTest(String data) async {
    // harusnya nanti yang dibawa disini adalah semua data, bukan cuma satu string
    final db = await dbInstance;

    final insertedId = await db.update(
        'profil',
        {
          'nama': data,
          'fotoProfil': 'kosong',
          'jenjang': 'Prakom Aja',
          'ak_now': 14.9,
        },
        where: 'id = ?',
        whereArgs: [1]);
  }
}
