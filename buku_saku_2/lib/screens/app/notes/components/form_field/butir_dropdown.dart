import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class ButirDropdown extends StatelessWidget {
  const ButirDropdown(
      {Key? key,
      required this.dataButir,
      required this.onChanged,
      this.selectedIndex})
      : super(key: key);

  final List<String> dataButir;
  final Function(String?) onChanged;
  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const FieldLabel(title: 'Butir Kegiatan'),
          DropdownSearch(
            mode: Mode.BOTTOM_SHEET,
            showClearButton: true,
            items: dataButir,
            popupItemDisabled: (String s) =>
                s.startsWith('I.A.1') || s.startsWith('II.A.1'),
            onChanged: onChanged,
            selectedItem:
                (selectedIndex == null) ? null : dataButir[selectedIndex!],
            dropdownSearchBaseStyle: AppConstants.kTextFieldTextStyle,
            dropdownSearchDecoration: AppConstants.kTextFieldDecoration(
              hintText: 'Pilih Butir Kegiatan...',
              borderSide: const BorderSide(
                color: AppColors.black,
                width: 4,
                style: BorderStyle.solid,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
