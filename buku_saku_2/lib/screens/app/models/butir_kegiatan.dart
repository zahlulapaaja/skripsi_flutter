class ButirKegiatan {
  String? kodeButir;

  String? title;

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

  ButirKegiatan.listUnsur(Map<String, dynamic> json) {
    code = json['unsur'];
    title = json['judul_unsur'];
    subunsur = json['subunsur'];
    // print(json['unsur']);

    // test = json['subunsur'];
    // print(test);
    // subUnsur = json['unsur']['subUnsur'][0]["kode"];
    // print(subUnsur);
  }

  ButirKegiatan.listSubUnsur(Map<String, dynamic> json, int index) {
    // kodeSubUnsur = json['subunsur']['kode'];
    // print(kodeSubUnsur);
    // jmlSubUnsur = json[index]['subunsur']['judul'];
    // subUnsur = json['unsur']['subUnsur'][0]["kode"];
    // print(subUnsur);
    // print(json);

    // code = json['subunsur'];

    // print(json['subunsur'][0]['kode']);
    // code = json['kode'];
    // title = json['judul'];
    // subUnsur = json['subunsur'];
    // subtitle = json['butir'].length;
    // print(code);
    // print('tes');
    // title = json['judul_unsur'];
    // subtitle = json['subunsur'].length;
    //
    // subunsur_title = List.generate(
    //     json['subunsur'].length, (index) => json['subunsur'][index]['judul']);
    // // print(json['subunsur'][0]['kode']);
    // print(subunsur_title);

    code = json['unsur'];
    title = json['judul_unsur'];

    print(json);
    // subUnsur = json['subunsur'];
    // subtitle = json['subunsur'];
    // print(subtitle);
    // code = json[0]['subunsur']['kode'];
    // title = json[0]['subunsur']['judul'];
    // // subUnsur = json['subunsur'];
    // subtitle = json[0]['subunsur']['butir'].length;
    // print(subtitle);
  }

  Map<String, dynamic> toMap() {
    return {
      'kode_butir': kodeButir,
      // 'butir_kegiatan': butirKegiatan,
    };
  }

  @override
  String toString() {
    return 'Note {title: $kodeButir, body: belon ada}';
  }
}
