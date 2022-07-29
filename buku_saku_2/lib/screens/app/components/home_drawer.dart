import 'dart:io';

import 'package:buku_saku_2/screens/app/models/profile.dart';
import 'package:buku_saku_2/screens/app/models/providers/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:buku_saku_2/configs/colors.dart';
import 'package:buku_saku_2/configs/constants.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key? key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;
  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.home,
        labelName: 'Beranda',
        icon: const Icon(Icons.home),
      ),
      DrawerList(
        index: DrawerIndex.export,
        labelName: 'Ekspor Catatan',
        icon: const Icon(Icons.file_download_outlined),
      ),
      DrawerList(
        index: DrawerIndex.rules,
        labelName: 'Dasar Peraturan',
        icon: const Icon(Icons.map),
      ),
      DrawerList(
        index: DrawerIndex.rate,
        labelName: 'Rate the app',
        icon: const Icon(Icons.share),
      ),
      DrawerList(
        index: DrawerIndex.about,
        labelName: 'About Us',
        icon: const Icon(Icons.info),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Profile? profil = context.watch<ProfileProvider>().profil;
    return Scaffold(
      backgroundColor: AppColors.midWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(1.0 -
                            (widget.iconAnimationController!.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                      begin: 0.0, end: 24.0)
                                  .animate(CurvedAnimation(
                                      parent: widget.iconAnimationController!,
                                      curve: Curves.fastOutSlowIn))
                                  .value /
                              360),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppColors.grey.withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60.0)),
                              child: (profil.fotoProfil == null)
                                  ? Image.asset(
                                      "assets/icons/profile.png",
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(profil.fotoProfil!),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      profil.nama ?? "",
                      style: const TextStyle(
                        fontFamily: AppConstants.fontName,
                        color: AppColors.black,
                        fontSize: AppConstants.kNormalFontSize + 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      "(${profil.jenjang?.jenjang ?? ''})",
                      style: const TextStyle(
                        fontFamily: AppConstants.fontName,
                        color: AppColors.black,
                        fontSize: AppConstants.kSmallFontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Divider(
            height: 1,
            color: AppColors.grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList?.length,
              itemBuilder: (BuildContext context, int index) {
                return menuList(drawerList![index]);
              },
            ),
          ),
          // Divider(
          //   height: 1,
          //   color: AppColors.grey.withOpacity(0.6),
          // ),
          //   Column(
          //     children: <Widget>[
          //       ListTile(
          //         title: const Text(
          //           'Sign Out',
          //           textAlign: TextAlign.left,
          //           style: TextStyle(
          //             fontFamily: AppConstants.fontName,
          //             color: AppColors.black,
          //             fontSize: AppConstants.kNormalFontSize,
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //         trailing: const Icon(
          //           Icons.power_settings_new,
          //           color: Colors.red,
          //         ),
          //         onTap: () {
          //         },
          //       ),
          //       SizedBox(
          //         height: MediaQuery.of(context).padding.bottom,
          //       )
          //     ],
          //   ),
        ],
      ),
    );
  }

  Widget menuList(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: AppColors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationToScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                      color: widget.screenIndex == listData.index
                          ? Colors.blue
                          : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName),
                        )
                      : Icon(listData.icon?.icon,
                          color: widget.screenIndex == listData.index
                              ? AppColors.primaryLight
                              : AppColors.primaryDark),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: AppConstants.fontName,
                      fontSize: AppConstants.kNormalFontSize,
                      fontWeight: FontWeight.w600,
                      color: widget.screenIndex == listData.index
                          ? AppColors.primaryLight
                          : AppColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController!.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

// INI DIA MASALAH DRAWER, JADI SCREENINDEXNYA GA KEGANTI, AKHIRNYA PINDAH KE HOME TERUS
  Future<void> navigationToScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }
}

enum DrawerIndex {
  home,
  export,
  rules,
  rate,
  about,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}
