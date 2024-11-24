
import 'package:flutter/material.dart';

class SampleProvider extends ChangeNotifier {

  var crazy = 20;
  var sense = 5;

  var result = 0;

  void calc() {
    result = crazy + sense;

  }
}
