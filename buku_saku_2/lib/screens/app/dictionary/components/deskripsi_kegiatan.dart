import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter/material.dart';

class DeskripsiKegiatan extends StatelessWidget {
  const DeskripsiKegiatan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: Text(
              'Deskripsi Kegiatan',
              style: AppConstants.kDictTitleTextStyle,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.info,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              '''Melakukan pemantauan implementasi prosedur pengelolaan kualitas data adalah proses menganalisa rangkaian kegiatan pengelolaan data dari mekanisme input hingga menjadi sebuah data yang siap diolah atau didiseminasikan lebih lanjut. Rangkaian kegiatan pengelolaan data dapat berupa standar pengelolaan data), validasi isian data dan proses memastikan kelengkapan data baik secara individu maupun batch. Tujuan kegiatan ini adalah memastikan setiap proses pengelolaannya sudah melewati standar yang telah diterapkan sehingga menghasilkan data yang berkualitas.
                Tahapan kegiatan ini mencakup namun tidak terbatas pada: 
 1. mengidentifikasi implementasi prosedur pengelolaan kualitas data yang akan dipantau;
 2. mengidentifikasi standar pengelolaan kualitas data yang akan digunakan;
 3. melakukan pemantauan proses pengelolaan data sudah sesuai dengan prosedur yang ditetapkan seperti urutan melakukan input data;
 4. melakukan pemantauan terhadap kelengkapan data (keterisian dan kelengkapan) sehingga menghasilkan data yang berkualitas dan terpercaya;
 5. melakukan pemantauan terhadap validasi set data yang telah dimasukkan sehingga memenuhi standar yang diharapkan; dan
 6. mendokumentasikan hasil kegiatan pemantauan (monitoring) implementasi prosedur pengelolaan kualitas data.''',
              textAlign: TextAlign.justify,
              style: AppConstants.kDictionaryTextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
