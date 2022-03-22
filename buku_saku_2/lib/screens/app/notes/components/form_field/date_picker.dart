import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    Key? key,
    required this.onChanged,
    this.selectedDate,
  }) : super(key: key);

  final Function(DateTime?) onChanged;
  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FieldLabel(title: 'Tanggal Kegiatan'),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: AppColors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: TextButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1990),
                  lastDate: DateTime(2040),
                ).then(onChanged);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDate!.day.toString() +
                        " / " +
                        selectedDate!.month.toString() +
                        " / " +
                        selectedDate!.year.toString(),
                    style: AppConstants.kTextFieldTextStyle,
                  ),
                  const Icon(
                    FontAwesomeIcons.calendar,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
