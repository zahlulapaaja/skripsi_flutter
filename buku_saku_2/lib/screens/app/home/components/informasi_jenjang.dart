import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/configs/colors.dart';

class InformasiJenjang extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const InformasiJenjang({Key? key, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 14.0, right: 14.0, top: 14.0, bottom: 24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppColors.grey.withOpacity(0.2),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 14.0),
                              child: Text(
                                'Jenjang',
                                textAlign: TextAlign.center,
                                style: AppConstants.kNormalTitleTextStyle,
                              ),
                            ),
                            Center(
                              child: Text(
                                'Pranata Komputer Mahir',
                                textAlign: TextAlign.center,
                                style: AppConstants.kNormalTitleTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        width: 10,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                        color: AppColors.grey,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 14.0),
                              child: Text(
                                'Butuh 45.123 AK menuju Pranata Komputer Penyelia',
                                textAlign: TextAlign.center,
                                style: AppConstants.kNormalTitleTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
