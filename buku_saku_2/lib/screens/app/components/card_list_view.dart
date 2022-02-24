import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'card_builder.dart';

class CardListView extends StatelessWidget {
  const CardListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      physics: const ScrollPhysics(), // to enable GridView's scrolling
      shrinkWrap: true, // You won't see infinite size error
      itemBuilder: (context, index) {
        return Card(
          color: AppColors.beige,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ClipPath(
            clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(color: AppColors.beigeDark, width: 7)),
                color: Colors.transparent,
              ),
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.topLeft,
              child: CardBuilder(
                index: index,
                title:
                    'Menyusun Rancangan Uji Coba Sistem Jaringan Komputer Lokal (Local Area Network)',
                description:
                    '''Menyusun rancangan uji coba sistem jaringan komputer lokal
(Local Area Network) adalah kegiatan membuat rancangan uji coba
untuk memastikan sistem jaringan komputer lokal dapat berfungsi
dengan baik.''',
                date: '22 Nov 2021',
              ),
            ),
          ),
        );
      },
    );
  }
}
