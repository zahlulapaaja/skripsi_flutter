import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/components/card_builder.dart';

class PinnedCardListView extends StatelessWidget {
  const PinnedCardListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
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
              padding: const EdgeInsets.all(20.0),
              alignment: Alignment.topLeft,
              child: CardBuilder(
                // ini supaya ga overflowed aja (sementara)
                index: index == 1 ? 3 : index,
                pinned: true,
                // title:
                //     'Menyusun Rancangan Uji Coba Sistem Jaringan Komputer Lokal (Local Area Network)',
                // description:
                //     '''Menyusun rancangan uji coba sistem jaringan komputer lokal (Local Area Network) adalah kegiatan membuat rancangan uji coba untuk memastikan sistem jaringan komputer lokal dapat berfungsi dengan baik.''',
                date: '22 Nov 2021',
              ),
            ),
          ),
        );
      },
    );
  }
}

// shaderCallback: (Rect bounds) {
// return LinearGradient(
// begin: Alignment.centerLeft,
// end: Alignment.centerRight,
// colors: <Color>[AppColors.offWhite, Colors.transparent],
// stops: [0.8, 1.0],
// ).createShader(bounds);
