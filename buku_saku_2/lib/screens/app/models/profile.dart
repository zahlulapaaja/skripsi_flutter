import 'package:buku_saku_2/screens/app/models/bukti_fisik.dart';
import 'package:buku_saku_2/screens/app/models/db/database.dart';

class Profile {
  int? id;
  String? nama;
  String? fotoProfil;

  Profile({
    this.id,
    this.nama,
    this.fotoProfil,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'fotoProfil': fotoProfil,
    };
  }
}
