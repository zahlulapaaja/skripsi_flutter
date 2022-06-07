import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class JumlahKegiatanField extends StatelessWidget {
  JumlahKegiatanField({
    Key? key,
    required this.initialAngkaKredit,
    required this.initialJmlKegiatan,
    this.onChanged,
  }) : super(key: key);

  final double initialAngkaKredit;
  final int initialJmlKegiatan;
  final Function(int)? onChanged;

  int maxJmlKegiatan = 100;
  bool maxKegiatan = false;
  bool minKegiatan = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const FieldLabel(title: 'Jumlah Kegiatan'),
                  Expanded(
                    child: NumberInputWithIncrementDecrement(
                      min: 1,
                      max: maxJmlKegiatan,
                      isInt: true,
                      onChanged: (val) {
                        onChanged!(val.toInt());
                      },
                      onIncrement: (val) {
                        onChanged!(val.toInt());
                      },
                      onDecrement: (val) {
                        onChanged!(val.toInt());
                      },
                      controller: TextEditingController(),
                      decIconSize: 20,
                      incIconSize: 20,
                      initialValue: initialJmlKegiatan,
                      numberFieldDecoration: AppConstants.kTextFieldDecoration(
                          borderSide: BorderSide.none),
                      widgetContainerDecoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
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
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                            (initialAngkaKredit * initialJmlKegiatan)
                                .toStringAsFixed(3),
                            style: AppConstants.kLargeTitleTextStyle),
                      ),
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
