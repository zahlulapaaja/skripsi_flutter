// ignore_for_file: file_names
import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    required this.iconData,
    this.index = 0,
    required this.selectedIconData,
    this.isSelected = false,
    this.animationController,
  });

  IconData iconData;
  IconData selectedIconData;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      // imagePath: 'assets/icons/tab_1.png',
      iconData: Icons.home_outlined,
      selectedIconData: Icons.home_rounded,
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      iconData: Icons.library_books_outlined,
      selectedIconData: Icons.library_books_rounded,
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      iconData: Icons.book_outlined,
      selectedIconData: Icons.book_rounded,
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      iconData: Icons.account_circle_outlined,
      selectedIconData: Icons.account_circle_rounded,
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
