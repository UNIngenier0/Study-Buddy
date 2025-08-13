import 'package:flutter/material.dart';

class BottomBarProvider extends ChangeNotifier {
  String _activeIcon = "home";

  String get activeIcon => _activeIcon;

  void setActiveIcon(String icon) {
    _activeIcon = icon;
    notifyListeners();
  }
}
