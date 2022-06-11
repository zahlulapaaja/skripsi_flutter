import 'package:buku_saku_2/screens/app/home/components/chart_angka_kredit.dart';
import 'package:buku_saku_2/screens/app/home/components/chart_angka_kredit_terkumpul.dart';
import 'package:buku_saku_2/screens/app/home/components/informasi_jenjang.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:provider/provider.dart';

class DetailAngkaKreditScreen extends StatefulWidget {
  static const id = 'detail_angka_kredit_screen';
  final AnimationController? animationController;
  const DetailAngkaKreditScreen({Key? key, this.animationController})
      : super(key: key);

  @override
  _DetailAngkaKreditScreenState createState() =>
      _DetailAngkaKreditScreenState();
}

class _DetailAngkaKreditScreenState extends State<DetailAngkaKreditScreen>
    with TickerProviderStateMixin {
  List<Widget> listViews = <Widget>[];

  @override
  void initState() {
    addAllListData();
    super.initState();
  }

  void addAllListData() {
    listViews.add(
      ChartAngkaKredit(
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      ChartAngkaKreditTerkumpul(
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      const InformasiJenjang(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.offWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder(
      future: context.read<NotesProvider>().notes,
      builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                    // bottomLeft: Radius.circular(32.0),
                    ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: AppColors.grey.withOpacity(0.4),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 8,
                      bottom: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Detail Angka Kredit',
                              textAlign: TextAlign.center,
                              style: AppConstants.kNavHeaderTextStyle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
