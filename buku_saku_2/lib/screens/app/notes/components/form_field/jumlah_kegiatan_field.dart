import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class JumlahKegiatanField extends StatelessWidget {
  const JumlahKegiatanField({Key? key, this.selectedData, this.onIncrement})
      : super(key: key);

  final int? selectedData;
  final Function(num)? onIncrement;

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
                      // TODO : Lengkapi logikanya
                      onChanged: (value) {
                        // selectedData['jml_kegiatan'] = value;
                      },
                      onIncrement: onIncrement,
                      onDecrement: (value) {
                        // selectedData['jml_kegiatan'] = value.toInt();
                        // setState(() {
                        //   selectedData['angka_kredit'] -= 0.104;
                        //   removeCheckboxBukti();
                        // });
                      },
                      controller: TextEditingController(),
                      decIconSize: 20,
                      incIconSize: 20,
                      initialValue: 1,
                      min: 1,
                      max: 10,
                      numberFieldDecoration: const InputDecoration(
                        contentPadding: EdgeInsets.zero,
                      ),
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
                      child: Text('$selectedData'),
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
