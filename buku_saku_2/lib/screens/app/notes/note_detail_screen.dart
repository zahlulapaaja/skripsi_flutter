import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoteDetailScreen extends StatefulWidget {
  static const id = 'note_detail_screen';
  const NoteDetailScreen({Key? key}) : super(key: key);

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  List<Widget> listViews = <Widget>[];

  // TODO : Ini laman detail, benerin gih

  @override
  void initState() {
    addAllListData();
    super.initState();
  }

  void addAllListData() {
    listViews.add(
      const SizedBox(height: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.offWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          heroTag: 'button3tag',
          onPressed: () {},
          backgroundColor: AppColors.primary,
          child: const Icon(FontAwesomeIcons.plus),
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
    return ListView.builder(
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: listViews.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return listViews[index];
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
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 12 - 4.0,
                  bottom: 8 - 4.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      FontAwesomeIcons.chevronLeft,
                      color: AppColors.offWhite,
                    ),
                    Expanded(
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
