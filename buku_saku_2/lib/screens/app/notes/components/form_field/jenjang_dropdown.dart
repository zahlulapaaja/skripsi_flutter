import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JenjangDropdown extends StatelessWidget {
  const JenjangDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String jenjang = context.read<ProfileProvider>().profil.jenjang!.jenjang;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const FieldLabel(title: 'Jenjang'),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: AppColors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: Text(
              jenjang,
              style: AppConstants.kTextFieldTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
