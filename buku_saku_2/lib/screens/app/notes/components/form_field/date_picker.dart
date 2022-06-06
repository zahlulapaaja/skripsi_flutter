import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DatePicker extends StatelessWidget {
  DatePicker({
    Key? key,
    required this.onChanged,
    this.selectedDate,
  }) : super(key: key);

  final Function(DateTime?) onChanged;
  final DateTime? selectedDate;
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String text = (selectedDate != null)
        ? selectedDate!.day.toString() +
            "-" +
            selectedDate!.month.toString() +
            "-" +
            selectedDate!.year.toString()
        : 'Pilih tanggal...';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FieldLabel(title: 'Tanggal Kegiatan'),
          Container(
            // padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: AppColors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        DatePill(text: text),
                        SizedBox(width: 5),
                        DatePill(text: text),
                        SizedBox(width: 5),
                        DatePill(text: text),
                        SizedBox(width: 5),
                        DatePill(text: text),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime(1990),
                      lastDate: DateTime(2040),
                    ).then(onChanged);
                  },
                  child: const Icon(
                    FontAwesomeIcons.plusCircle,
                    color: AppColors.black,
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

class DatePill extends StatelessWidget {
  const DatePill({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.primaryLight.withOpacity(0.75),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontFamily: AppConstants.fontName,
              color: AppColors.black,
              fontSize: AppConstants.kTinyFontSize,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 5),
          RawMaterialButton(
            onPressed: () {},
            // constraints: BoxConstraints(maxWidth: 15),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            constraints: BoxConstraints(minWidth: 0),
            fillColor: Colors.white,
            // textStyle: TextStyle(),
            child: Icon(
              FontAwesomeIcons.times,
              size: 10,
            ),
            shape: CircleBorder(),
          )
        ],
      ),
    );
  }
}
