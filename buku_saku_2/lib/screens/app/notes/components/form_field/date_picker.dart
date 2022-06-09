import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    Key? key,
    required this.onAdd,
    required this.onReduced,
    required this.selectedDate,
  }) : super(key: key);

  final Function(DateTime?) onAdd;
  final Function(DateTime) onReduced;
  final List<DateTime> selectedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FieldLabel(title: 'Tanggal Kegiatan'),
          Container(
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: (selectedDate.isEmpty)
                          ? [
                              const Text(
                                "Pilih Tanggal...",
                                style: AppConstants.kTextFieldHintStyle,
                              )
                            ]
                          : List.generate(selectedDate.length, (index) {
                              return DatePill(
                                date: selectedDate[index],
                                reducedButton: true,
                                onReduced: onReduced,
                              );
                            }),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1990),
                      lastDate: DateTime(2040),
                    ).then(onAdd);
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
  const DatePill(
      {Key? key,
      required this.date,
      this.onReduced,
      this.reducedButton = false})
      : super(key: key);

  final DateTime date;
  final bool reducedButton;
  final Function(DateTime)? onReduced;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.primaryLight.withOpacity(0.75),
      ),
      child: Row(
        children: [
          Padding(
            padding: reducedButton
                ? const EdgeInsets.only(right: 8)
                : const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              date.day.toString() +
                  "/" +
                  date.month.toString() +
                  "/" +
                  date.year.toString(),
              style: const TextStyle(
                fontFamily: AppConstants.fontName,
                color: AppColors.black,
                fontSize: AppConstants.kTinyFontSize,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (reducedButton)
            RawMaterialButton(
              onPressed: () {
                onReduced!(date);
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              constraints: const BoxConstraints(minWidth: 0),
              child: const Icon(
                FontAwesomeIcons.timesCircle,
                size: 18,
              ),
              shape: const CircleBorder(),
            ),
        ],
      ),
    );
  }
}
