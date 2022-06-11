import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:provider/provider.dart';

class InformasiJenjang extends StatelessWidget {
  const InformasiJenjang({
    Key? key,
    this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    Profile profil = context.watch<ProfileProvider>().profil;
    double targetAK = context.watch<ProfileProvider>().akMenujuNaikPangkat;

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return Container(
          margin: const EdgeInsets.only(
              left: 14.0, right: 14.0, top: 14.0, bottom: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 14.0),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Jenjang',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppConstants.fontName,
                        color: AppColors.grey.withOpacity(0.8),
                        fontSize: AppConstants.kNormalFontSize,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        profil.jenjang!.jenjang,
                        textAlign: TextAlign.center,
                        style: AppConstants.kNormalTitleTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
                child: Center(
                  child: Container(
                    margin: const EdgeInsetsDirectional.only(start: 1, end: 1),
                    width: 3,
                    height: 60,
                    color: AppColors.lightGrey,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Butuh ${targetAK.toStringAsFixed(3)} AK untuk Naik Pangkat',
                    textAlign: TextAlign.center,
                    style: AppConstants.kNormalTitleTextStyle,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
