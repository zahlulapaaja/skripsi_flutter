import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/models/providers/dictionary_provider.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ButirDropdown extends StatelessWidget {
  ButirDropdown({
    Key? key,
    required this.onChanged,
    this.selectedData,
    this.alert,
    this.editMode = false,
  }) : super(key: key);

  final Function(ButirKegiatan?) onChanged;
  final bool editMode;
  final String? alert;

  String? selectedData;
  List<String> dataButir = [];
  List<double> dataAK = [];
  List<String> disableButir = [];
  late List<ButirKegiatan> allButir;

  List<String> getData(List<ButirKegiatan> allButir) {
    dataAK = [];
    return List<String>.generate(
      allButir.length,
      (index) {
        dataAK.add(allButir[index].angkaKredit);
        return allButir[index].kode + " " + allButir[index].judul;
      },
      growable: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    allButir = context.read<DictionaryProvider>().allButir;
    disableButir = context.read<DictionaryProvider>().disableButir;
    dataButir = getData(allButir);

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
              int i = 0;
              while (i < disableButir.length) {
                if (s.contains(disableButir[i])) return true;
                i++;
              }
              return false;
            },
            onChanged: (String? judul) {
              ButirKegiatan? selectedButir;
              selectedData = judul;

              if (judul != null) {
                String kodeButir = judul.split(' ')[0];
                selectedButir = allButir
                    .singleWhere((element) => element.kode == kodeButir);
              }

              onChanged(selectedButir);
            },
            selectedItem: selectedData,
            dropdownSearchBaseStyle: AppConstants.kTextFieldTextStyle,
            dropdownSearchDecoration: AppConstants.kTextFieldDecoration(
              contentPadding: (selectedData == null)
                  ? const EdgeInsets.only(left: 10)
                  : const EdgeInsets.only(top: 10, bottom: 10, left: 10),
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
          if (alert != null)
            Text(
              alert!,
              style: const TextStyle(
                fontFamily: AppConstants.fontName,
                color: AppColors.beigeDark,
                fontSize: AppConstants.kTinyFontSize,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}
