import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key? key,
    required this.onChangeTanggalMulai,
    required this.onChangeTanggalBerakhir,
    required this.selectedDate,
    required this.jmlKegiatan,
  }) : super(key: key);

  final Function(DateTime?, int) onChangeTanggalMulai;
  final Function(DateTime?, int) onChangeTanggalBerakhir;
  final List<TanggalKegiatan?> selectedDate;
  final int jmlKegiatan;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FieldLabel(title: 'Tanggal Kegiatan'),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: const <Widget>[
                Expanded(
                  child: Text(
                    "(Tanggal Mulai)",
                    textAlign: TextAlign.center,
                    style: AppConstants.kTextFieldHintStyle,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "(Tanggal Berakhir)",
                    textAlign: TextAlign.center,
                    style: AppConstants.kTextFieldHintStyle,
                  ),
                ),
              ],
            ),
          ),
          for (var i = 0; i < widget.jmlKegiatan; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Expanded(
                    child: DateField(
                      date: widget.selectedDate[i]?.tanggalMulai,
                      onChange: (date) {
                        widget.onChangeTanggalMulai(date, i);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DateField(
                      date: widget.selectedDate[i]?.tanggalBerakhir,
                      onChange: (date) {
                        if (widget.selectedDate[i]?.tanggalMulai == null) {
                          Fluttertoast.showToast(
                            msg: "Pilih tanggal mulai terlebih dahulu",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: AppColors.alert.withOpacity(0.9),
                            textColor: Colors.white,
                            fontSize: AppConstants.kTinyFontSize,
                          );
                        } else {
                          widget.onChangeTanggalBerakhir(date, i);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class DateField extends StatelessWidget {
  const DateField({
    Key? key,
    required this.date,
    required this.onChange,
  }) : super(key: key);

  final DateTime? date;
  final Function(DateTime?) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: AppColors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: (date == null)
                  ? const Text(
                      "Pilih tanggal...",
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: AppConstants.kTinyFontSize,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  : Text(
                      (DateFormat("dd/MM/yyyy", "id_ID").format(date!))
                          .toString(),
                      style: const TextStyle(
                        fontFamily: AppConstants.fontName,
                        color: AppColors.black,
                        fontSize: AppConstants.kSmallFontSize,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
            ),
          ),
          (date == null)
              ? TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1990),
                      lastDate: DateTime(DateTime.now().year + 1),
                    ).then((date) {
                      if (date != null) onChange(date);
                    });
                  },
                  child: const Icon(
                    Icons.edit_calendar_rounded,
                    color: AppColors.black,
                    size: AppConstants.kHugeFontSize - 6,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    onChange(null);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 20,
                  ),
                ),
        ],
      ),
    );
  }
}

class DatePill extends StatelessWidget {
  const DatePill({Key? key, required this.date}) : super(key: key);
  final TanggalKegiatan date;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      margin: const EdgeInsets.only(right: 5, top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.primaryLight.withOpacity(0.75),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          (date.tanggalBerakhir == null)
              ? (DateFormat("dd/MM/yyyy", "id_ID").format(date.tanggalMulai!))
                  .toString()
              : (DateFormat("dd/MM/yyyy", "id_ID").format(date.tanggalMulai!))
                      .toString() +
                  " - " +
                  (DateFormat("dd/MM/yyyy", "id_ID")
                          .format(date.tanggalBerakhir!))
                      .toString(),
          style: const TextStyle(
            fontFamily: AppConstants.fontName,
            color: AppColors.black,
            fontSize: AppConstants.kTinyFontSize,
            decoration: TextDecoration.none,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
