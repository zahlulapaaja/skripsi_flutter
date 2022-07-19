import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/models/butir_kegiatan.dart';
import 'package:buku_saku_2/screens/app/models/providers/dictionary_provider.dart';
import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButirDropdown extends StatefulWidget {
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

  @override
  State<ButirDropdown> createState() => _ButirDropdownState();
}

class _ButirDropdownState extends State<ButirDropdown> {
  List<String> dataButir = [];
  List<String> disableButir = [];
  List<ButirKegiatan> allButir = [];

  List<String> getData(List<ButirKegiatan> butirList) {
    return List<String>.generate(
      butirList.length,
      (index) {
        return butirList[index].kode + " " + butirList[index].judul;
      },
    );
  }

  @override
  void initState() {
    allButir = context.read<DictionaryProvider>().allButir;
    disableButir = context.read<DictionaryProvider>().disableButir;
    dataButir = getData(allButir);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const FieldLabel(title: 'Butir Kegiatan'),
          DropdownSearch<String>(
            enabled: widget.editMode ? false : true,
            items: dataButir,
            // mode: Mode.BOTTOM_SHEET,
            popupProps: PopupProps.bottomSheet(
              showSearchBox: true,
              disabledItemFn: (String s) {
                int i = 0;
                while (i < disableButir.length) {
                  if (s.contains(disableButir[i])) return true;
                  i++;
                }
                return false;
              },
            ),
            clearButtonProps:
                ClearButtonProps(isVisible: widget.editMode ? false : true),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: AppConstants.kTextFieldDecoration(
                contentPadding: (widget.selectedData == null)
                    ? const EdgeInsets.only(left: 10)
                    : const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                hintText: 'Pilih Butir Kegiatan...',
                borderSide: const BorderSide(
                  color: AppColors.black,
                  width: 4,
                  style: BorderStyle.solid,
                ),
              ),
              baseStyle: AppConstants.kTextFieldTextStyle,
            ),
            // showClearButton: widget.editMode ? false : true,
            // KENAPA DATANYA DOBEL, jadi syntax dibawah diapus biar ga dobel
            // showSearchBox: true,
            // onFind: (String? filter) => Future.delayed(Duration.zero, () {
            //   return findData(filter);
            // }),
            // popupItemDisabled: (String s) {
            //   int i = 0;
            //   while (i < disableButir.length) {
            //     if (s.contains(disableButir[i])) return true;
            //     i++;
            //   }
            //   return false;
            // },
            onChanged: (String? judul) {
              ButirKegiatan? selectedButir;
              setState(() {
                widget.selectedData = judul;
              });

              if (judul != null) {
                String kodeButir = judul.split(' ')[0];
                selectedButir = allButir
                    .singleWhere((element) => element.kode == kodeButir);
              }
              widget.onChanged(selectedButir);
            },
            selectedItem: widget.selectedData,

            validator: (value) {
              if (value == null) {
                return 'Data tidak boleh kosong';
              }
              return null;
            },
          ),
          if (widget.alert != null)
            Text(
              widget.alert!,
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

  List<String> findData(String? searchKey) {
    var matchedList = <String>[];
    searchKey ??= '';
    for (String butir in dataButir) {
      if (butir.contains(searchKey)) matchedList.add(butir);
    }
    return matchedList;
  }
}
