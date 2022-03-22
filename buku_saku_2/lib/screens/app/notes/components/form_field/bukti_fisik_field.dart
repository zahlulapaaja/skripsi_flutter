import 'package:buku_saku_2/screens/app/notes/components/field_label.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuktiFisikField extends StatefulWidget {
  const BuktiFisikField({Key? key, this.selectedData}) : super(key: key);
  final Map<int, bool>? selectedData;

  @override
  _BuktiFisikFieldState createState() => _BuktiFisikFieldState();
}

class _BuktiFisikFieldState extends State<BuktiFisikField> {
  List<Widget> checkboxBukti = [
    const FieldLabel(title: 'Bukti Fisik'),
  ];

  addCheckboxBukti({required int index}) {
    if (widget.selectedData![index] == null) {
      widget.selectedData![index] = false;
    }

    // TODO : Masih belom berrubah tampilannya ketika diklik, tapi nilainya udh berubah
    // tapi abis itu ga berubah lagi sih, cma sekali berubahnya

    checkboxBukti.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  checkColor: Colors.white,
                  // fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: widget.selectedData![index],
                  onChanged: (bool? value) {
                    setState(() {
                      widget.selectedData![index] = value!;
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              const Text('Disini nama buktinya apa'),
            ],
          ),
          Row(
            children: const [
              Icon(FontAwesomeIcons.times),
              Icon(FontAwesomeIcons.eye),
            ],
          ),
        ],
      ),
    );
  }

  removeCheckboxBukti() {
    checkboxBukti.removeLast();
  }

  @override
  void initState() {
    super.initState();
    addCheckboxBukti(index: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: checkboxBukti,
      ),
    );
  }
}
