import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlueGridContainer extends StatelessWidget {
  BlueGridContainer({
    Key? key,
    required this.satuanHasil,
    required this.angkaKredit,
    required this.batasanPenilaian,
    required this.pelaksana,
  }) : super(key: key);

  final String satuanHasil;
  final double angkaKredit;
  final String batasanPenilaian;
  final String pelaksana;

  final List<String> titles = [
    'Satuan Hasil',
    'Angka Kredit',
    'Batasan Penilaian',
    'Pelaksana',
  ];

  final List<String> bodies = [];

  @override
  Widget build(BuildContext context) {
    return AlignedGridView.count(
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 8.0),
      shrinkWrap: true,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount: 2,
      itemCount: 4,
      itemBuilder: (context, index) {
        Size size = MediaQuery.of(context).size;
        bodies.add(satuanHasil);
        bodies.add(angkaKredit.toString());
        bodies.add(batasanPenilaian);
        bodies.add(pelaksana);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: Row(
                children: <Widget>[
                  SvgPicture.asset("assets/icons/document.svg", width: 20),
                  const SizedBox(width: 5),
                  Text(
                    titles[index],
                    style: AppConstants.kDictTitleTextStyle,
                  ),
                ],
              ),
            ),
            Container(
              width: size.width / 2 - 20,
              height: 100,
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.info,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: AutoSizeText(
                bodies[index],
                textAlign: TextAlign.center,
                style: AppConstants.kDictionaryTextStyle(),
              ),
            ),
          ],
        );
      },
    );
  }
}
