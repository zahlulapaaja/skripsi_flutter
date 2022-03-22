import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class JenjangDropdown extends StatelessWidget {
  const JenjangDropdown(
      {Key? key, required this.dataJenjang, required this.onChanged})
      : super(key: key);

  final List<String> dataJenjang;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FieldLabel(title: 'Jenjang'),
          DropdownSearch<String>(
            enabled: false,
            mode: Mode.BOTTOM_SHEET,
            items: dataJenjang,
            popupItemDisabled: (String s) => s.startsWith('I'),
            onChanged: onChanged,
            // TODO : Nanti dibawah sini pakai data profil, dan gabisa diubah
            selectedItem: dataJenjang[0],
            dropdownSearchBaseStyle: AppConstants.kTextFieldTextStyle,
            dropdownSearchDecoration: AppConstants.kTextFieldDecoration(
              hintText: 'Jenjang Jabatan saat ini',
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
