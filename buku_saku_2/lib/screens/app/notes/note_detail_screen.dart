import 'package:buku_saku_2/screens/app/dictionary/components/batasan_penilaian.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/deskripsi_kegiatan.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/detail_butir.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/menu_unsur.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:buku_saku_2/screens/app/components/searchbox.dart';
import 'package:buku_saku_2/screens/app/dictionary/components/menu_kamus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoteDetailScreen extends StatefulWidget {
  static const id = 'note_detail_screen';
  const NoteDetailScreen({Key? key}) : super(key: key);

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  List<Widget> listViews = <Widget>[];

  // TODO : OTW bikin screen detail catatan (kalo bisa sih beda sama screen edit/tambah nya)

  @override
  void initState() {
    addAllListData();
    super.initState();
  }

  void addAllListData() {
    listViews.add(
      SizedBox(height: 20),
    );

    listViews.add(
      DetailButir(),
    );
    listViews.add(
      DeskripsiKegiatan(),
    );
    listViews.add(
      BatasanPenilaian(),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.offWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          heroTag: 'button3tag',
          onPressed: () {
            print('tambah catatan');
          },
          backgroundColor: AppColors.primary,
          child: Icon(FontAwesomeIcons.plus),
        ),
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
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
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
        Container(
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
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 12 - 4.0,
                  bottom: 8 - 4.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.chevronLeft,
                      color: AppColors.offWhite,
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Detail Catatan',
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
        ),
      ],
    );
  }
}
