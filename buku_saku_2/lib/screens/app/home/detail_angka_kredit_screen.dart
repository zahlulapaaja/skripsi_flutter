import 'package:buku_saku_2/screens/app/components/app_bar_ui.dart';
import 'package:buku_saku_2/screens/app/home/components/chart_angka_kredit.dart';
import 'package:buku_saku_2/screens/app/home/components/chart_angka_kredit_terkumpul.dart';
import 'package:buku_saku_2/screens/app/home/components/informasi_jenjang.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
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
            const AppBarUI(title: 'Detail Angka Kredit'),
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
        if (snapshot.hasError) {
          return Center(child: Text('Error fetching data: ${snapshot.error}'));
        } else if (snapshot.hasData) {
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
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
