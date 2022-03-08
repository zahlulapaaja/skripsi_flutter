import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DropdownMenu extends StatelessWidget {
  DropdownMenu({Key? key}) : super(key: key);

  final List<String> data = [
    'Prakom Ahli Pertama',
    'Prakom Ahli Madya',
    'Prakom Ahli Utama'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FieldLabel(title: 'Jenjang'),
          DropdownSearch<String>(
            mode: Mode.BOTTOM_SHEET,
            showClearButton: true,
            items: data,
            hint: "Jenjang Jabatan saat ini",
            // popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: print,
            selectedItem: data[0],
            dropdownSearchDecoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 10),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.black,
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
