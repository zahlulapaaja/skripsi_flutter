import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:flutter/material.dart';

class UraianTextArea extends StatelessWidget {
  const UraianTextArea({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const FieldLabel(title: 'Uraian Kegiatan'),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: AppColors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Data tidak boleh kosong';
                  }
                  return null;
                },
                maxLength: 255,
                maxLines: 8,
                decoration: const InputDecoration.collapsed(
                  hintText: "Masukkan uraian kegiatan...",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintStyle: TextStyle(
                    fontFamily: AppConstants.fontName,
                    color: AppColors.grey,
                    fontSize: AppConstants.kSmallFontSize,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
