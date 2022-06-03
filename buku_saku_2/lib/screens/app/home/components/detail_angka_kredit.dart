import 'package:buku_saku_2/screens/app/models/db/database.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class DetailAngkaKredit extends StatefulWidget {
  const DetailAngkaKredit({Key? key}) : super(key: key);

  @override
  State<DetailAngkaKredit> createState() => _DetailAngkaKreditState();
}

class _DetailAngkaKreditState extends State<DetailAngkaKredit> {
  var dbHelper = DbHelper();
  Profile? data;

  @override
  Widget build(BuildContext context) {
    data = context.watch<ProfileProvider>().profil;

    return Padding(
      padding: const EdgeInsets.only(
          left: 14.0, right: 14.0, top: 14.0, bottom: 24.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
            topRight: Radius.circular(68.0),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.grey.withOpacity(0.2),
              offset: const Offset(1.1, 1.1),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Halo ' + data!.nama! + "...",
                              style: const TextStyle(
                                fontFamily: AppConstants.fontName,
                                fontWeight: FontWeight.w600,
                                fontSize: AppConstants.kNormalFontSize,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: 48,
                                width: 2,
                                decoration: BoxDecoration(
                                  color: AppColors.success.withOpacity(0.5),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, bottom: 2),
                                      child: Text(
                                        "snapshot.data!",
                                        // TODO : kondisikan ternary dengan snapshotnya, ah itulah pokoknya, bikin lebih rapi kondisinya
                                        // karena sekarang kondisinya masih keluar error, karna waktu datanya belom ada, tetep dipaksa dipanggil
                                        // 'PAK Saat Ini',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppConstants.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              AppConstants.kNormalFontSize,
                                          letterSpacing: -0.1,
                                          color: AppColors.lightBlack
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 28,
                                          height: 28,
                                          child: SvgPicture.asset(
                                            "assets/icons/star.svg",
                                            color: AppColors.success,
                                            semanticsLabel: "data",
                                            // 'PAK Saat Ini',
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, bottom: 3),
                                          child: Text(
                                            (23.541).toStringAsFixed(3),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontFamily: AppConstants.fontName,
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  AppConstants.kNormalFontSize,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: <Widget>[
                              Container(
                                height: 48,
                                width: 2,
                                decoration: BoxDecoration(
                                  color:
                                      AppColors.primaryLight.withOpacity(0.5),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, bottom: 2),
                                      child: Text(
                                        'AK Terkumpul',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppConstants.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              AppConstants.kNormalFontSize,
                                          letterSpacing: -0.1,
                                          color: AppColors.lightBlack
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        SizedBox(
                                          width: 28,
                                          height: 28,
                                          child: SvgPicture.asset(
                                            "assets/icons/star.svg",
                                            color: AppColors.primary,
                                            semanticsLabel: 'AK Terkumpul',
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, bottom: 3),
                                          child: Text(
                                            (23.541).toStringAsFixed(3),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontFamily: AppConstants.fontName,
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  AppConstants.kNormalFontSize,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100.0),
                                ),
                                border: Border.all(
                                    width: 4,
                                    color:
                                        AppColors.primaryDark.withOpacity(0.2)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    (75.999).toStringAsFixed(3),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: AppConstants.fontName,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 24,
                                      letterSpacing: 0.0,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Text(
                                    'Angka Kredit',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: AppConstants.fontName,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AppConstants.kTinyFontSize - 2,
                                      letterSpacing: 0.0,
                                      color: AppColors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CustomPaint(
                              painter: CurvePainter(colors: [
                                AppColors.primaryDark,
                                AppColors.primary,
                                AppColors.primaryLight,
                              ], angle: 140 + (360 - 140)),
                              child: const SizedBox(
                                width: 108,
                                height: 108,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
              child: Container(
                height: 2,
                decoration: const BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Jabatan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: AppConstants.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: AppConstants.kTinyFontSize,
                              letterSpacing: -0.2,
                              color: AppColors.lightBlack,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColors.beige,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'Prakom Ahli Madya',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontFamily: AppConstants.fontName,
                                    fontWeight: FontWeight.w600,
                                    fontSize: AppConstants.kSmallFontSize - 1,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Angka Kredit',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: AppConstants.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: AppConstants.kTinyFontSize,
                            letterSpacing: -0.2,
                            color: AppColors.lightBlack,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.beige,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                'Sudah Terkumpul 12,658 Angka Kredit',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: AppConstants.fontName,
                                  fontWeight: FontWeight.w600,
                                  fontSize: AppConstants.kSmallFontSize - 1,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final double? angle;
  final List<Color>? colors;

  CurvePainter({this.colors, this.angle = 140});

  @override
  void paint(Canvas canvas, Size size) {
    List<Color> colorsList = [];
    if (colors != null) {
      colorsList = colors ?? [];
    } else {
      colorsList.addAll([Colors.white, Colors.white]);
    }

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.4)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final shadowPaintCenter = Offset(size.width / 2, size.height / 2);
    final shadowPaintRadius =
        math.min(size.width / 2, size.height / 2) - (14 / 2);
    canvas.drawArc(
        Rect.fromCircle(center: shadowPaintCenter, radius: shadowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shadowPaint);

    shadowPaint.color = Colors.grey.withOpacity(0.3);
    shadowPaint.strokeWidth = 16;
    canvas.drawArc(
        Rect.fromCircle(center: shadowPaintCenter, radius: shadowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shadowPaint);

    shadowPaint.color = Colors.grey.withOpacity(0.2);
    shadowPaint.strokeWidth = 20;
    canvas.drawArc(
        Rect.fromCircle(center: shadowPaintCenter, radius: shadowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shadowPaint);

    shadowPaint.color = Colors.grey.withOpacity(0.1);
    shadowPaint.strokeWidth = 22;
    canvas.drawArc(
        Rect.fromCircle(center: shadowPaintCenter, radius: shadowPaintRadius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        shadowPaint);

    final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = SweepGradient(
      startAngle: degreeToRadians(268),
      endAngle: degreeToRadians(270.0 + 360),
      tileMode: TileMode.repeated,
      colors: colorsList,
    );
    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (14 / 2);

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        degreeToRadians(278),
        degreeToRadians(360 - (365 - angle!)),
        false,
        paint);

    const gradient1 = SweepGradient(
      tileMode: TileMode.repeated,
      colors: [Colors.white, Colors.white],
    );

    var cPaint = Paint();
    cPaint.shader = gradient1.createShader(rect);
    cPaint.color = Colors.white;
    cPaint.strokeWidth = 14 / 2;
    canvas.save();

    final centerToCircle = size.width / 2;
    canvas.save();

    canvas.translate(centerToCircle, centerToCircle);
    canvas.rotate(degreeToRadians(angle! + 2));

    canvas.save();
    canvas.translate(0.0, -centerToCircle + 14 / 2);
    canvas.drawCircle(const Offset(0, 0), 14 / 5, cPaint);

    canvas.restore();
    canvas.restore();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
