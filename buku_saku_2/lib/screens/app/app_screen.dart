import 'package:buku_saku_2/screens/app/sidebar/export_note.dart';
import 'package:buku_saku_2/screens/app/dictionary/screens/jenjang_screen.dart';
import 'package:buku_saku_2/screens/app/models/db/db_profile.dart';
import 'package:buku_saku_2/screens/app/models/providers/dictionary_provider.dart';
import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:buku_saku_2/screens/app/models/providers/notes_provider.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:buku_saku_2/screens/app/models/providers/screen_provider.dart';
import 'package:buku_saku_2/screens/app/profile/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/app/controllers/drawer_user_controller.dart';
import 'package:buku_saku_2/screens/app/components/home_drawer.dart';
import 'package:buku_saku_2/screens/app/models/tabIcon_data.dart';
import 'package:buku_saku_2/screens/app/home/home_screen.dart';
import 'package:buku_saku_2/screens/app/notes/notes_screen.dart';
import 'package:buku_saku_2/screens/app/notes/add_note_screen.dart';
import 'package:buku_saku_2/screens/app/dictionary/dictionary_screen.dart';
import 'package:buku_saku_2/screens/app/components/bottom_bar_view.dart';
import 'package:provider/provider.dart';

class AppScreen extends StatefulWidget {
  static const id = 'app_screen';
  final int? defaultIndex;

  const AppScreen({Key? key, this.defaultIndex = 0}) : super(key: key);
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  DrawerIndex? drawerIndex;

  var dbHelper = DbProfile();

  void initialTabBody() {
    for (var tabIcon in tabIconsList) {
      tabIcon.isSelected = false;
    }

    Future.delayed(Duration.zero, () {
      if (widget.defaultIndex == 0) {
        tabIconsList[0].isSelected = true;
        context.read<ScreenProvider>().setTabBody =
            HomeScreen(animationController: animationController);
      } else if (widget.defaultIndex == 1) {
        tabIconsList[1].isSelected = true;
        context.read<ScreenProvider>().setTabBody = const NotesScreen();
      }
    });
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    initialTabBody();
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
      child: FutureBuilder(
          future: context.read<ProfileProvider>().getProfileData,
          builder: (context, AsyncSnapshot<Profile> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('ERROR!! ${snapshot.error}'));
            } else if (snapshot.hasData) {
              // kalo data kosong arahin dulu ke laman edit profil
              // kasih alert dulu biar ga tiba2 sampe ke laman edit profil, intinya lebih rapi lah
              int akNaikPangkat =
                  context.read<ProfileProvider>().pangkatSaatIni.akNaikPangkat!;
              context.read<DictionaryProvider>().setNaikPangkat = akNaikPangkat;
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: DrawerUserController(
                  screenIndex: drawerIndex,
                  drawerWidth: MediaQuery.of(context).size.width * 0.75,
                  onDrawerCall: (DrawerIndex drawerIndexData) {
                    changeIndex(drawerIndexData);
                    //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
                  },
                  screenView: GestureDetector(
                    onTap: () =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    child: Stack(
                      children: <Widget>[
                        context.watch<ScreenProvider>().tabBody,
                        bottomBar(),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
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
            switch (index) {
              case 0:
                animationController?.reverse().then<dynamic>((data) {
                  if (!mounted) return;
                  context.read<NotesProvider>().setQuery = '';
                  context.read<ScreenProvider>().setTabBody =
                      HomeScreen(animationController: animationController);
                });
                break;

              case 1:
                animationController?.reverse().then<dynamic>((data) {
                  if (!mounted) return;
                  context.read<NotesProvider>().setQuery = '';
                  context.read<ScreenProvider>().setTabBody =
                      const NotesScreen();
                });
                break;

              case 2:
                animationController?.reverse().then<dynamic>((data) {
                  if (!mounted) return;
                  context.read<ScreenProvider>().setTabBody =
                      const DictionaryScreen();
                  context.read<DictionaryProvider>().setDictionaryList =
                      const JenjangScreen();
                  context.read<DictionaryProvider>().setSearchboxExist = false;
                  context.read<DictionaryProvider>().setQuery = '';
                });
                break;

              case 3:
                Navigator.pushNamed(context, SettingScreen.id);
                break;
            }
          },
        ),
      ],
    );
  }

  void changeIndex(DrawerIndex drawerIndexData) {
    if (drawerIndex != drawerIndexData) {
      drawerIndex = drawerIndexData;

      // TODO : Jangan lupa nanti diganti semua print yang ini
      // Keknya ga perlu ya untuk ganti drawerIndex ini, tapi sementara aku tinggalin satu dulu disini, sebagai contoh
      // ignore: missing_enum_constant_in_switch
      switch (drawerIndex) {
        case DrawerIndex.home:
          drawerIndex = DrawerIndex.home;
          break;
        case DrawerIndex.export:
          Navigator.pushNamed(context, ExportNotesScreen.id);
          break;
        case DrawerIndex.rules:
          print('DrawerIndex.rules');
          break;
        case DrawerIndex.feedBack:
          print('DrawerIndex.feedBack');
          break;
        case DrawerIndex.share:
          print('DrawerIndex.share');
          break;
        case DrawerIndex.about:
          print('DrawerIndex.about');
          break;
      }
    }
  }
}
