import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/models/dictionary_provider.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ButirDropdown extends StatelessWidget {
  ButirDropdown(
      {Key? key,
      required this.onChanged,
      this.initialData,
      this.editMode = false})
      : super(key: key);

  final Function(String?) onChanged;
  final String? initialData;
  final bool editMode;
  List<String>? dataButir;

  getData(DictionaryProvider dictProvider) {
    var data = dictProvider.allButir;
    dataButir = List<String>.generate(
      data.length,
      (index) {
        return data[index].kode + " " + data[index].judul;
      },
      growable: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dictProvider = Provider.of<DictionaryProvider>(context);
    getData(dictProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const FieldLabel(title: 'Butir Kegiatan'),
          DropdownSearch(
            enabled: editMode ? false : true,
            mode: Mode.BOTTOM_SHEET,
            showClearButton: editMode ? false : true,
            items: dataButir,
            popupItemDisabled: (String s) {
              return s.contains('I.A.1') || s.startsWith('II.A.1');
            },
            onChanged: onChanged,
            selectedItem: initialData,
            dropdownSearchBaseStyle: AppConstants.kTextFieldTextStyle,
            dropdownSearchDecoration: AppConstants.kTextFieldDecoration(
              hintText: 'Pilih Butir Kegiatan...',
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
