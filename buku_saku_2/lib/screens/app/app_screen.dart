import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/dictionary/dictionary_screen.dart';
import 'package:buku_saku_2/screens/app/models/tabIcon_data.dart';
import 'package:buku_saku_2/screens/app/notes/notes_screen.dart';
import 'package:flutter/material.dart';
import 'components/bottom_bar_view.dart';
import 'home/home_screen.dart';

class AppScreen extends StatefulWidget {
  static const id = 'app_screen';

  const AppScreen({Key? key}) : super(key: key);
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    // warna bakground default, cuma kontainer kosong, klo udh bikin halaman, container ini ga guna
    color: AppColors.offWhite,
  );

  @override
  void initState() {
    for (var tabIcon in tabIconsList) {
      tabIcon.isSelected = false;
    }
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    tabBody = HomeScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.offWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    // TODO: ini cuma delayed buatan, jangan lupa dihapus nanti
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            print('tambah catatan');
          },
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      HomeScreen(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      NotesScreen(animationController: animationController);
                });
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = DictionaryScreen(
                      animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
