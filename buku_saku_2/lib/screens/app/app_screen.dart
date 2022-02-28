import 'package:buku_saku_2/screens/app/home/detail_angka_kredit_screen.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/dictionary/dictionary_screen.dart';
import 'package:buku_saku_2/screens/app/drawer_user_controller.dart';
import 'package:buku_saku_2/screens/app/home_drawer.dart';
import 'package:buku_saku_2/screens/app/models/tabIcon_data.dart';
import 'package:buku_saku_2/screens/app/notes/notes_screen.dart';
import 'package:buku_saku_2/screens/app/home/home_screen.dart';
import 'components/bottom_bar_view.dart';

class AppScreen extends StatefulWidget {
  static const id = 'app_screen';

  const AppScreen({Key? key}) : super(key: key);
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  DrawerIndex? drawerIndex;

  Widget tabBody = Container(
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
              return DrawerUserController(
                screenIndex: drawerIndex,
                drawerWidth: MediaQuery.of(context).size.width * 0.75,
                onDrawerCall: (DrawerIndex drawerIndexData) {
                  changeIndex(drawerIndexData);
                  //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
                },
                screenView: Stack(
                  children: <Widget>[
                    tabBody,
                    bottomBar(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    // TODO: ini cuma delayed buatan, jangan lupa dihapus nanti
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
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

  void changeIndex(DrawerIndex drawerIndexData) {
    if (drawerIndex != drawerIndexData) {
      drawerIndex = drawerIndexData;
      if (drawerIndex == DrawerIndex.HOME) {
        print('home');
        setState(() {
          // screenView = const MyHomePage();
        });
      } else if (drawerIndex == DrawerIndex.Help) {
        setState(() {
          // screenView = HelpScreen();
        });
      } else if (drawerIndex == DrawerIndex.FeedBack) {
        setState(() {
          // screenView = FeedbackScreen();
        });
      } else if (drawerIndex == DrawerIndex.Invite) {
        setState(() {
          // screenView = InviteFriend();
        });
      } else {
        //do in your way......
      }
    }
  }
}
