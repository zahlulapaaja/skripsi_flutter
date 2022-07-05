import 'package:buku_saku_2/configs/components.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class ChartAngkaKreditTerkumpul extends StatelessWidget {
  ChartAngkaKreditTerkumpul({
    Key? key,
    this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;
  final List<Color> colorList = [
    AppColors.primary,
    AppColors.primaryLight,
  ];

  @override
  Widget build(BuildContext context) {
    double akTerkumpul = 0;
    double persenAKUtama = 0;
    double persenAKPenunjang = 0;
    double akUtama = context.watch<NotesProvider>().akUtamaTerkumpul;
    double akPenunjang = context.watch<NotesProvider>().akPenunjangTerkumpul;
    akTerkumpul = akUtama + akPenunjang;
    if (akTerkumpul != 0) {
      persenAKUtama = akUtama / (akTerkumpul) * 100;
      persenAKPenunjang = akPenunjang / (akTerkumpul) * 100;
    }

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return Container(
          margin: const EdgeInsets.only(left: 14.0, right: 14.0, top: 14.0),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
                child: Text(
                  'Angka Kredit Terkumpul',
                  textAlign: TextAlign.start,
                  style: AppConstants.kNormalTitleTextStyle,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: PieChart(
                      dataMap: {
                        "Unsur Utama": akUtama,
                        "Unsur Penunjang": akPenunjang,
                      },
                      animationDuration: const Duration(milliseconds: 1000),
                      chartRadius: MediaQuery.of(context).size.width / 3.2,
                      colorList: colorList,
                      initialAngleInDegree: 270,
                      chartType: ChartType.disc,
                      ringStrokeWidth: 32,
                      legendOptions: const LegendOptions(showLegends: false),
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValueBackground: false,
                        decimalPlaces: 3,
                        chartValueStyle: AppConstants.kSmallWhiteTextStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.circle,
                              color: colorList[0],
                              size: 12,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Unsur Utama",
                                  style: AppConstants.kCardBodyTextStyle,
                                ),
                                Text(
                                  "${AppComponents.convertNumberToId(akUtama)} (${persenAKUtama.toInt()}%)",
                                  style: AppConstants.kNormalTitleTextStyle,
                                ),
                              ],
                            )),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.circle,
                              color: colorList[1],
                              size: 12,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Unsur Penunjang",
                                  style: AppConstants.kCardBodyTextStyle,
                                ),
                                Text(
                                  "${AppComponents.convertNumberToId(akPenunjang)} (${persenAKPenunjang.toInt()}%)",
                                  style: AppConstants.kNormalTitleTextStyle,
                                ),
                              ],
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
