class Profile {
  int? id;
  String? nama;
  String? fotoProfil;
  Jenjang? jenjang;
  double? akSaatIni;
  List<Jenjang>? listJenjang;

  Profile({
    this.id,
    this.nama,
    this.fotoProfil,
    this.jenjang,
    this.akSaatIni,
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
