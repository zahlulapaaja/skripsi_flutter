class Profile {
  int? id;
  String? nama;
  String? fotoProfil;
  Jenjang? jenjang;
  double akSaatIni;
  List<Jenjang>? listJenjang;

  Profile({
    this.id,
    this.nama,
    this.fotoProfil,
    this.jenjang,
    this.akSaatIni = 0,
    this.listJenjang,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'fotoProfil': fotoProfil,
      "idJenjang": jenjang!.id,
      "akSaatIni": akSaatIni,
    };
  }

  Map<String, dynamic> toProfileMap() {
    return {
      'path': fotoProfil,
      'name': fotoProfil!.split("/").last,
      'extension': fotoProfil!.split(".").last,
      // ini perlu perbaiki
      'size': 0,
    };
  }
}

class Jenjang {
  int id;
  int kodeJenjang;
  String jenjang;
  String golongan;

  Jenjang({
    required this.id,
    required this.kodeJenjang,
    required this.jenjang,
    required this.golongan,
  });
}
