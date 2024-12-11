import 'package:flutter/material.dart';

import '../../home/view/home_screen.dart';
import '../../productList_dir/view/product_list_screen.dart';

class DashBoardProvider extends ChangeNotifier {
  var selectedIndex = 0;
  var pageName = 'Storri';

  final List<Widget> screens = [
    const HomeScreen(),
    //
    const ProductListScreen(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    switch (index) {
      case 0:
        pageName = 'Storri';
        break;
      case 1:
        pageName = 'Activities';
        break;
      case 2:
        pageName = 'Profile';
        break;
    // case 3:
    //   pageName = 'Profile';
    //   break;
    }
    notifyListeners();
  }
}

class CounterModel extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  String name = "Henry Akpan";

  void changeName() {
    name = "Akanimo Ekong";
    notifyListeners();
  }

  void increment() {
    _count++;
    notifyListeners();
  }
}



