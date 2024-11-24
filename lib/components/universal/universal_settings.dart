import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;
  void increment() {
    _count++;
    notifyListeners();
  }
}

class ThemeModel with ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
