class Unsur {
  String? code;
  String? title;
  String? subtitle;
  List<SubUnsur>? subunsurList;

  Unsur.fromJson(Map<String, dynamic> json) {
    code = json['unsur'];
    title = json['judul_unsur'];
    subtitle = json['subunsur'].length.toString() + " Sub Unsur";
    subunsurList = List.generate(json['subunsur'].length, (i) {
      return SubUnsur(
        code: json['subunsur'][i]['kode'],
        title: json['subunsur'][i]['judul'],
        butirList: List.generate(json['subunsur'][i]['butir'].length, (j) {
          return ButirKegiatan(
            kode: json['subunsur'][i]['butir'][j]['kode'],
            judul: json['subunsur'][i]['butir'][j]['judul'],
            uraian: json['subunsur'][i]['butir'][j]['uraian'],
            satuanHasil: json['subunsur'][i]['butir'][j]['satuan_hasil'],
            angkaKredit: json['subunsur'][i]['butir'][j]['angka_kredit'],
            batasanPenilaian: json['subunsur'][i]['butir'][j]
                ['batasan_penilaian'],
            pelaksana: json['subunsur'][i]['butir'][j]['pelaksana'],
            buktiFisik: json['subunsur'][i]['butir'][j]['bukti_fisik'],
            contoh: json['subunsur'][i]['butir'][j]['contoh'],
          );
        }),
      );
    });
  }
}

class SubUnsur {
  final String code;
  final String title;
  final List<ButirKegiatan> butirList;

  SubUnsur({
    required this.code,
    required this.title,
    required this.butirList,
  });
}

class ButirKegiatan {
  final String kode;
  final String judul;
  final String uraian;
  final String satuanHasil;
  final double angkaKredit;
  final String batasanPenilaian;
  final String pelaksana;
  final String buktiFisik;
  final String contoh;
  String? unsurCode;
  String? unsurTitle;
  String? subUnsurCode;
  String? subUnsurTitle;

  ButirKegiatan({
    required this.kode,
    required this.judul,
    required this.uraian,
    required this.satuanHasil,
    required this.angkaKredit,
    required this.batasanPenilaian,
    required this.pelaksana,
    required this.buktiFisik,
    required this.contoh,
    this.unsurCode,
    this.unsurTitle,
    this.subUnsurCode,
    this.subUnsurTitle,
  });
}
