import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    required this.iconData,
    required this.selectedIconData,
    this.index = 0,
    this.isSelected = false,
    this.animationController,
  });

  final IconData iconData;
  final IconData selectedIconData;
  final int index;
  bool isSelected;
  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
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
