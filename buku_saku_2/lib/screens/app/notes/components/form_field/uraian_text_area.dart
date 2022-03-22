import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:flutter/material.dart';

class UraianTextArea extends StatelessWidget {
  const UraianTextArea({Key? key, required this.onChanged}) : super(key: key);

  final Function(String?) onChanged;

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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                maxLines: 8,
                decoration: const InputDecoration.collapsed(
                    hintText: "Enter your text here"),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
