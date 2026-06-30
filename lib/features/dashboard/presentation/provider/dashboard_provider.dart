import 'package:flutter/material.dart';

enum DrawerItem {
  home,
  bookmark,
  wallstreet,
}

class DashBoardProvider extends ChangeNotifier {
  DrawerItem selectedItem = DrawerItem.home;

  void ChageScreen(DrawerItem item) {
    selectedItem = item;
    notifyListeners();
  }
}