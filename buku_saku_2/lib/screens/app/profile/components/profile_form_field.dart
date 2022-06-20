import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';

class ProfileFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final bool obsecureText;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const ProfileFormField({
    Key? key,
    required this.title,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    this.obsecureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(title: title),
        TextField(
          controller: controller,
          textInputAction: TextInputAction.done,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: keyboardType,
          obscureText: obsecureText,
          decoration: AppConstants.kTextFieldDecoration(
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            borderSide: const BorderSide(
              color: AppColors.black,
              width: 4,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ],
    );
  }
}
