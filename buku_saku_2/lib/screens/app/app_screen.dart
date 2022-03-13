import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/drawer_user_controller.dart';
import 'package:buku_saku_2/screens/app/home_drawer.dart';
import 'package:buku_saku_2/screens/app/models/note.dart';
import 'package:buku_saku_2/screens/app/models/database.dart';
import 'package:buku_saku_2/screens/app/models/tabIcon_data.dart';
import 'package:buku_saku_2/screens/app/home/home_screen.dart';
import 'package:buku_saku_2/screens/app/notes/notes_screen.dart';
import 'package:buku_saku_2/screens/app/notes/add_note_screen.dart';
import 'package:buku_saku_2/screens/app/dictionary/dictionary_screen.dart';
import 'package:buku_saku_2/screens/app/components/bottom_bar_view.dart';

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

  late Future<List<Note>> notes;
  var dbHelper;

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

    super.initState();
    dbHelper = DbHelper();
    loadNotes();

    // tabBody = HomeScreen(
    //   animationController: animationController,
    //   notes: getNotes(),
    // );
  }

  loadNotes() {
    setState(() {
      notes = dbHelper.getNotes();
    });
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
        body: FutureBuilder(
          future: getData(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != true) {
                tabBody = const Center(child: Text('still empty'));
              } else {
                tabBody = HomeScreen(
                  animationController: animationController,
                  // notes: snapshot.data,
                );
              }
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
            } else if (snapshot.hasError) {
              return const Center(child: Text('error fetching notes'));
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    // Future<List<Note>>> notes;
    // TODO: ini cuma delayed buatan, jangan lupa dihapus nanti
    // dan cukup diganti sama data future
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
            Navigator.pushNamed(context, AddNoteScreen.id);
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
