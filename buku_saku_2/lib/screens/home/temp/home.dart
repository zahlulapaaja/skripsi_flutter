import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/screens/home/temp/components/body.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/screens/home/temp/components/bottom_navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'models/tab_icon_data.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppColors.primary,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    // tabBody = MyDiaryScreen(animationController: animationController);
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
      child: Scaffold(
        appBar: buildAppBar(),
        body: Body(),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.primary,
      leading: IconButton(
        icon: Image.asset("assets/icons/menu.png"),
        onPressed: () {},
      ),
    );
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        // BottomBarView(
        //   tabIconsList: tabIconsList,
        //   addClick: () {},
        //   changeIndex: (int index) {
        //     if (index == 0 || index == 2) {
        //       animationController?.reverse().then<dynamic>((data) {
        //         if (!mounted) {
        //           return;
        //         }
        //         setState(() {
        //           tabBody =
        //               MyDiaryScreen(animationController: animationController);
        //         });
        //       });
        //     } else if (index == 1 || index == 3) {
        //       animationController?.reverse().then<dynamic>((data) {
        //         if (!mounted) {
        //           return;
        //         }
        //         setState(() {
        //           tabBody =
        //               TrainingScreen(animationController: animationController);
        //         });
        //       });
        //     }
        //   },
        // ),
      ],
    );
  }
}
