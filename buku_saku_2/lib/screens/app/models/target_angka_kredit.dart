class TargetAngkaKredit {
  String? jenjang;
  String? golongan;
  int akMinimal = 0;
  int akNaikPangkat = 0;
  bool? pangkatPuncak;
  String? syaratPendidikan;
  int? akPemeliharaan;
  int? pengembanganProfesi;
  String? syaratNaikPangkat;
  String? jenjangSelanjutnya;
  String? golonganSelanjutnya;
  int? akNaikJenjang;

  TargetAngkaKredit({this.akMinimal = 0, this.akNaikPangkat = 0});

  TargetAngkaKredit.fromJson(Map<String, dynamic> json) {
    jenjang = json['jenjang'];
    golongan = json['golongan'];
    akMinimal = json['ak_minimal'];
    akNaikPangkat = json['ak_naik_pangkat'];
    pangkatPuncak = json['pangkat_puncak'];
    syaratPendidikan = json['syarat_pendidikan'];
    akPemeliharaan = json['ak_pemeliharaan'];
    pengembanganProfesi = json['pengembangan_profesi'];
    syaratNaikPangkat = json['syarat_naik_pangkat'];
  }
}
