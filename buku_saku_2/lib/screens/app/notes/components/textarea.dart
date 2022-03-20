import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';

class TextArea extends StatelessWidget {
  const TextArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FieldLabel(title: 'Uraian Kegiatan'),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.black),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 8,
                decoration:
                    InputDecoration.collapsed(hintText: "Enter your text here"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
