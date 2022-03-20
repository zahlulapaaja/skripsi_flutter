import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class JumlahKegiatan extends StatefulWidget {
  const JumlahKegiatan({Key? key}) : super(key: key);

  @override
  State<JumlahKegiatan> createState() => _JumlahKegiatanState();
}

class _JumlahKegiatanState extends State<JumlahKegiatan> {
  // DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const FieldLabel(title: 'Jumlah Kegiatan'),
                  Expanded(
                    child: NumberInputWithIncrementDecrement(
                      controller: TextEditingController(),
                      decIconSize: 20,
                      incIconSize: 20,
                      numberFieldDecoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const FieldLabel(title: 'Angka Kredit'),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: const Text('Halo'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
