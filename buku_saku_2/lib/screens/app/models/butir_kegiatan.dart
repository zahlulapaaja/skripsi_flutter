class ButirKegiatan {
  String? kodeButir;

  String? title;
  String? subtitle;

  String? kodeSubUnsur;
  String? code;
  List<dynamic>? subunsur;
  // List<dynamic>? subunsur_title;
  // final String? butirKegiatan;
  // final String? satuanHasil;
  // final int? batasanPenelitian;
  // final double? angkaKredit;
  // final String? pelaksana;
  // final String? buktiFisik;
  // final String? contoh;

  ButirKegiatan({
    this.kodeButir,
    this.code,
  });

  ButirKegiatan.fromJson(Map<String, dynamic> json) {
    code = json['unsur'];
    title = json['judul_unsur'];
    subtitle = 'subtitle';
    subunsur = json['subunsur'];
  }

  Map<String, dynamic> toMap() {
    return {
      'kode_butir': kodeButir,
      // 'butir_kegiatan': butirKegiatan,
    };
  }
}
