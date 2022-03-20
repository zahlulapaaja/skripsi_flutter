class ButirKegiatan {
  String? code;
  String? title;
  String? subtitle;
  List<dynamic>? subunsur;

  ButirKegiatan.fromJson(Map<String, dynamic> json) {
    code = json['unsur'];
    title = json['judul_unsur'];
    subunsur = json['subunsur'];
  }
}
