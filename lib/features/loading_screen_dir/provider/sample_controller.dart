import 'package:flutter/material.dart';

class SampleProvider extends ChangeNotifier {
  var crazy = 20;
  var sense = 5;

  var result = 0;

  void calc() {
    result = crazy + sense;
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
