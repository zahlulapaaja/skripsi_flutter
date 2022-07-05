import 'package:buku_saku_2/configs/components.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class ChartAngkaKredit extends StatelessWidget {
  ChartAngkaKredit({
    Key? key,
    this.animationController,
  }) : super(key: key);

  final AnimationController? animationController;
  final List<Color> colorList = [
    AppColors.success,
    AppColors.primary,
    AppColors.secondary,
    AppColors.warning,
    AppColors.primaryLight,
  ];

  @override
  Widget build(BuildContext context) {
    Profile profil = context.watch<ProfileProvider>().profil;
    double akUtama = context.watch<NotesProvider>().akUtamaTerkumpul;
    double akPenunjang = context.watch<NotesProvider>().akPenunjangTerkumpul;
    double akNaikPangkat = context
        .watch<ProfileProvider>()
        .pangkatSaatIni
        .akNaikPangkat
        .toDouble();
    double totalAK = profil.akSaatIni + akUtama + akPenunjang;

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return Container(
          margin: const EdgeInsets.only(left: 14.0, right: 14.0, top: 20.0),
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
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Angka Kredit',
                  style: AppConstants.kLargeTitleTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: PieChart(
                  dataMap: {
                    "Angka Kredit Saat Ini": profil.akSaatIni,
                    "Angka Kredit Terkumpul": akUtama + akPenunjang,
                  },
                  animationDuration: const Duration(milliseconds: 1000),
                  chartRadius: MediaQuery.of(context).size.width / 2,
                  colorList: colorList,
                  initialAngleInDegree: 270,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 25,
                  centerText: AppComponents.convertNumberToId(totalAK),
                  centerTextStyle: const TextStyle(
                    fontFamily: AppConstants.fontName,
                    color: AppColors.black,
                    fontSize: AppConstants.kHugeFontSize,
                    fontWeight: FontWeight.w900,
                  ),
                  legendOptions: const LegendOptions(showLegends: false),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValuesInPercentage: true,
                    showChartValueBackground: false,
                    showChartValuesOutside: true,
                    chartValueStyle: AppConstants.kDetailCardTextStyle,
                  ),
                  baseChartColor: AppColors.lightGrey,
                  totalValue: akNaikPangkat.toDouble(),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
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
                                "Angka kredit saat ini",
                                style: AppConstants.kCardBodyTextStyle,
                              ),
                              Text(
                                AppComponents.convertNumberToId(
                                    profil.akSaatIni),
                                style: AppConstants.kNormalTitleTextStyle,
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Row(
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
                                "Angka kredit terkumpul",
                                style: AppConstants.kCardBodyTextStyle,
                              ),
                              Text(
                                AppComponents.convertNumberToId(
                                    akUtama + akPenunjang),
                                style: AppConstants.kNormalTitleTextStyle,
                              ),
                            ],
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
