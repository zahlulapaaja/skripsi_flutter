import 'package:buku_saku_2/screens/app/models/db/db_profile.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:buku_saku_2/screens/app/models/providers/dictionary_provider.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:buku_saku_2/screens/app/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:buku_saku_2/screens/app/app_screen.dart';
import 'package:buku_saku_2/screens/app/home/detail_angka_kredit_screen.dart';
import 'package:buku_saku_2/screens/app/home/components/header_with_searchbox.dart';
import 'package:buku_saku_2/screens/app/home/components/detail_angka_kredit.dart';
import 'package:buku_saku_2/screens/app/home/components/title_view.dart';
import 'package:buku_saku_2/screens/app/models/providers/screen_provider.dart';
import 'package:buku_saku_2/screens/app/notes/components/card_grid_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';
  final AnimationController? animationController;
  const HomeScreen({Key? key, this.animationController}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;
  var dbHelper = DbProfile();
  dynamic result;

  @override
  initState() {
    Profile data = context.read<ProfileProvider>().profil;
    context.read<DictionaryProvider>().setJenjang = data;
    if (data.id == null) {
      Future.delayed(Duration.zero, () async {
        while (result == null) {
          result = await alertDialog();
          // kalo abis ke profile screen trus balik bakal error nanti
          if (result == "Lanjutkan")
            Navigator.popAndPushNamed(context, EditProfileScreen.id);
          // Navigator.pushNamed(context, EditProfileScreen.id);
        }
      });
    }
    int akNaikPangkat =
        context.read<ProfileProvider>().pangkatSaatIni.akNaikPangkat;
    context.read<DictionaryProvider>().setNaikPangkat = akNaikPangkat;

    addAllListData();
    scrollControllerAnimation();

    super.initState();
  }

  scrollControllerAnimation() {
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
  }

  void addAllListData() {
    const int count = 9;

    listViews.add(
      HeaderWithSearchbox(),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Angka Kredit',
        detailBtn: true,
        onTap: () {
          context.read<ScreenProvider>().setTabBody = DetailAngkaKreditScreen(
              animationController: widget.animationController);
        },
      ),
    );

    listViews.add(
      DetailAngkaKredit(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 1, 1.0,
                curve: Curves.fastOutSlowIn))),
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Catatan Terbaru',
        detailBtn: true,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AppScreen(defaultIndex: 1)));
        },
      ),
    );

    context.read<NotesProvider>().orderByKodeButir = false;
    listViews.add(
      const CardGridView(),
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
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
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
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Opacity(
                              opacity: topBarOpacity,
                              child: const Text(
                                'Buku Saku Prakom',
                                textAlign: TextAlign.center,
                                style: AppConstants.kNavHeaderTextStyle,
                              ),
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

  Future<String?> alertDialog() async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Data Profil'),
        content: const Text('Masukkan data profil untuk memulai aplikasi ini'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Lanjutkan'),
            child: const Text('Lanjutkan'),
          ),
        ],
      ),
    );
  }
}
