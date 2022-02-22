import 'package:buku_saku_2/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CardGridView extends StatelessWidget {
  const CardGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      itemCount: 10,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
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

class CardBuilder extends StatelessWidget {
  final int? index;
  final String title;
  final String description;
  final String date;

  const CardBuilder(
      {Key? key,
      this.index,
      required this.title,
      required this.description,
      required this.date})
      : super(key: key);

  getNoteIcon() {
    if (index == 2) {
      return SvgPicture.asset("assets/icons/important.svg");
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.black,
                fontSize: AppConstants.kMediumFontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 7),
            Text(
              description,
              maxLines: index == 1 ? 10 : 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.black,
                fontSize: AppConstants.kSmallFontSize,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 7),
            Text(
              date,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: AppConstants.kSmallFontSize,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment(2.0, 1.0),
          heightFactor: 0.5,
          child: FloatingActionButton(
            onPressed: () {
              print("tombol ditekan");
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: SvgPicture.asset("assets/icons/three-dots.svg"),
          ),
        ),
        Positioned(
          height: 20,
          width: 20,
          right: 0,
          bottom: 0,
          child: getNoteIcon(),
        ),
      ],
    );
  }
}
