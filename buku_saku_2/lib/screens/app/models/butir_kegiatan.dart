class ButirKegiatan {
  String? kodeButir;

  String? title;
  String? subtitle;

  String? kodeSubUnsur;
  String? code;
  List<dynamic>? subunsur;

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
}
