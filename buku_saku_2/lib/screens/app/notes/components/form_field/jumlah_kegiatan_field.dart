import 'package:buku_saku_2/configs/components.dart';
import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:provider/provider.dart';

class JumlahKegiatanField extends StatefulWidget {
  const JumlahKegiatanField({
    Key? key,
    required this.akSatuan,
    required this.initialJmlKegiatan,
    this.onChanged,
  }) : super(key: key);

  final double akSatuan;
  final int initialJmlKegiatan;
  final Function(int)? onChanged;

  @override
  State<JumlahKegiatanField> createState() => _JumlahKegiatanFieldState();
}

class _JumlahKegiatanFieldState extends State<JumlahKegiatanField> {
  int maxJmlKegiatan = 100;
  bool maxKegiatan = false;
  bool minKegiatan = false;
  int jmlKegiatan = 1;

  @override
  Widget build(BuildContext context) {
    ButirKegiatan? butir = context.read<ProfileProvider>().selectedButir;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
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
                            setState(() {
                              jmlKegiatan = val.toInt();
                            });
                            widget.onChanged!(val.toInt());
                          },
                          onIncrement: (val) {
                            setState(() {
                              jmlKegiatan = val.toInt();
                            });
                            widget.onChanged!(val.toInt());
                          },
                          onDecrement: (val) {
                            setState(() {
                              jmlKegiatan = val.toInt();
                            });
                            widget.onChanged!(val.toInt());
                          },
                          controller: TextEditingController(),
                          decIconSize: 20,
                          incIconSize: 20,
                          initialValue: widget.initialJmlKegiatan,
                          numberFieldDecoration:
                              AppConstants.kTextFieldDecoration(
                                  borderSide: BorderSide.none),
                          widgetContainerDecoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: AppColors.black),
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
                            border:
                                Border.all(width: 1, color: AppColors.black),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              NumberFormatter.convertToId(
                                  widget.akSatuan * widget.initialJmlKegiatan),
                              style: AppConstants.kLargeTitleTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                if (jmlKegiatan > 1)
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      alignment: Alignment.bottomCenter,
                      iconSize: 36,
                      splashRadius: 36,
                      onPressed: () async {
                        await showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Batasan Penilaian'),
                            content: Text(butir!.batasanPenilaian),
                          ),
                        );
                      },
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.error_rounded,
                        color: AppColors.warning,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const Text(
            "Angka kredit yang dicatat adalah angka kredit penuh",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: AppConstants.fontName,
              color: AppColors.beigeDark,
              fontSize: AppConstants.kTinyFontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
