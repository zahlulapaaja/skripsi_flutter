import 'package:buku_saku_2/screens/app/components/card_list_view.dart';
import 'package:buku_saku_2/screens/app/notes/components/pinned_card_list_view.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:buku_saku_2/screens/app/components/searchbox.dart';
import 'package:buku_saku_2/screens/app/components/title_view.dart';
import 'package:buku_saku_2/screens/app/components/card_grid_view.dart';
import 'package:buku_saku_2/screens/app/notes/components/pinned_card_grid_view.dart';
import 'package:buku_saku_2/screens/app/notes/components/multi_title_view.dart';

class NotesScreen extends StatefulWidget {
  static const id = 'notes_screen';
  final AnimationController? animationController;
  const NotesScreen({Key? key, this.animationController}) : super(key: key);

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  bool isListView = false;
  int activeTextButton = 0;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: widget.animationController!,
      curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn),
    ));
    addAllData(false);

    scrollController.addListener(() {
      if (scrollController.offset >= 72) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 72 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 72) {
          setState(() {
            topBarOpacity = scrollController.offset / 72;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllData(bool isListView) {
    const int count = 9;
    List<String> titleTxt = ['Catatan Terbaru', 'Kategori', 'Semua Catatan'];

    listViews.add(
      SearchBox(),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Pinned',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      isListView ? PinnedCardListView() : PinnedCardGridView(),
    );

    listViews.add(
      SizedBox(height: 20),
    );

    listViews.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[AppColors.offWhite, Colors.transparent],
              stops: [0.8, 1.5],
            ).createShader(bounds);
          },
          child: SizedBox(
            height: 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: titleTxt.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      print('tombol $index ditekan');
                      setState(() {
                        activeTextButton = index;
                      });
                    },
                    child: Text(
                      titleTxt[index],
                      textAlign: TextAlign.left,
                      style: index == activeTextButton
                          ? AppConstants.kTitleActiveTextStyle
                          : AppConstants.kTitleViewTextStyle,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );

    listViews.add(
      isListView ? CardListView() : CardGridView(),
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
            controller: scrollController,
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
            return Transform(
              transform: Matrix4.translationValues(
                  0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: const BorderRadius.only(
                      // bottomLeft: Radius.circular(32.0),
                      ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppColors.grey.withOpacity(0.4 * topBarOpacity),
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
                        top: 12 - 4.0 * topBarOpacity,
                        bottom: 8 - 4.0 * topBarOpacity,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Daftar Catatan',
                                textAlign: TextAlign.center,
                                style: AppConstants.kNavHeaderTextStyle,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('ganti tampilan');
                              listViews = [];
                              setState(() {
                                isListView = !isListView;
                                addAllData(isListView);
                              });
                            },
                            child: SvgPicture.asset(
                              isListView
                                  ? "assets/icons/grid-view.svg"
                                  : "assets/icons/list-view.svg",
                              color: Colors.white,
                              semanticsLabel: 'List view icons',
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
