import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter/material.dart';

class KegiatanTimField extends StatefulWidget {
  const KegiatanTimField({
    Key? key,
    required this.isChecked,
    required this.jmlAnggotaController,
    this.initialDataPeran,
    required this.onCheckboxChanged,
    required this.onRadioButtonChanged,
  }) : super(key: key);

  final bool isChecked;
  final Function(bool?) onCheckboxChanged;
  final Function(String?) onRadioButtonChanged;
  final TextEditingController jmlAnggotaController;
  final String? initialDataPeran;

  @override
  State<KegiatanTimField> createState() => _KegiatanTimFieldState();
}

class _KegiatanTimFieldState extends State<KegiatanTimField> {
  String? _peranDalamTim;

  @override
  void initState() {
    _peranDalamTim = widget.initialDataPeran;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CheckboxListTile(
          title: const Text(
            "Kegiatan Tim",
            style: AppConstants.kFieldLabel,
          ),
          checkColor: AppColors.offWhite,
          activeColor: AppColors.primaryLight,
          value: widget.isChecked,
          onChanged: widget.onCheckboxChanged,
          controlAffinity: ListTileControlAffinity.leading,
        ),
        if (widget.isChecked)
          Container(
            padding: const EdgeInsets.only(left: 70, right: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Jumlah anggota tim :",
                      style: AppConstants.kDetailCardTextStyle,
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 70,
                      height: 30,
                      child: TextFormField(
                        controller: widget.jmlAnggotaController,
                        textInputAction: TextInputAction.done,
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.black,
                              width: 4,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                RadioButton(
                  value: "Penyusun Utama",
                  peranTimVal: _peranDalamTim,
                  onChanged: (value) {
                    setState(() {
                      _peranDalamTim = value;
                      widget.onRadioButtonChanged(value);
                    });
                  },
                ),
                RadioButton(
                  value: "Penyusun Pembantu",
                  peranTimVal: _peranDalamTim,
                  onChanged: (value) {
                    setState(() {
                      _peranDalamTim = value;
                      widget.onRadioButtonChanged(value);
                    });
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class RadioButton extends StatelessWidget {
  const RadioButton({
    Key? key,
    required this.value,
    required this.peranTimVal,
    required this.onChanged,
  }) : super(key: key);

  final String? peranTimVal;
  final String value;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 30,
          child: Radio<String>(
            value: value.toLowerCase(),
            groupValue: peranTimVal,
            toggleable: true,
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          height: 20,
          child: TextButton(
            onPressed: () {
              onChanged(value.toLowerCase());
            },
            style: ButtonStyle(
              splashFactory: NoSplash.splashFactory,
              padding: MaterialStateProperty.all(EdgeInsets.zero),
            ),
            child: const Text(
              "Penyusun Utama",
              style: AppConstants.kDetailCardTextStyle,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
