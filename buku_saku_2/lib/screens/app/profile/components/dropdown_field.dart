import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  const DropdownField({
    Key? key,
    required this.title,
    required this.data,
    required this.onChanged,
    this.initialData,
    this.hintText,
    this.validator,
  }) : super(key: key);

  final Function(String?) onChanged;
  final String title;
  final String? hintText;
  final String? initialData;
  final List<String> data;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        FieldLabel(title: title),
        DropdownSearch<String>(
          items: data,
          onChanged: onChanged,
          selectedItem: initialData,
          clearButtonProps: const ClearButtonProps(isVisible: true),
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: AppConstants.kTextFieldDecoration(
              hintText: hintText,
              borderSide: const BorderSide(
                color: AppColors.black,
                width: 4,
                style: BorderStyle.solid,
              ),
            ),
            baseStyle: AppConstants.kTextFieldTextStyle,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
