import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 4),
      child: Text(
        title,
        style: AppConstants.kFieldLabel,
      ),
    );
  }
}
