import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropdownField extends StatelessWidget {
  const DropdownField({
    Key? key,
    required this.title,
    required this.data,
    required this.onChanged,
    this.initialData,
    this.jenjang,
  }) : super(key: key);

  final Function(String?) onChanged;
  final String title;
  final String? initialData;
  final String? jenjang;
  final List<String> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FieldLabel(title: title),
          DropdownSearch(
            mode: Mode.MENU,
            showClearButton: false,
            items: data,
            onChanged: onChanged,
            selectedItem: initialData,
            dropdownSearchBaseStyle: AppConstants.kTextFieldTextStyle,
            dropdownSearchDecoration: AppConstants.kTextFieldDecoration(
              hintText: "Pilih $title...",
              borderSide: const BorderSide(
                color: AppColors.black,
                width: 4,
                style: BorderStyle.solid,
              ),
            ),
            validator: (value) {
              if (value == null) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
