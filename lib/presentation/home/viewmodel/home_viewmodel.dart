import 'package:flutter/material.dart';
import 'dart:math';

class HomeViewModel extends ChangeNotifier {
  final List<String> featuredTrees = [
    'assets/images/tree1.png',
    'assets/images/tree2.png',
    'assets/images/tree3.png',
  ];

  final List<String> dailyTips = [
    'Plant a tree today to help our planet.',
    'Reduce paper usage to save forests.',
    'Learn about native trees in your area.',
    'Water plants regularly for a greener earth.',
    'Support local tree conservation projects.',
  ];

  final Random _random = Random();
  int _tipIndex = 0;

  String get currentTip => dailyTips[_tipIndex];

  void nextTip() {
    _tipIndex = _random.nextInt(dailyTips.length);
    notifyListeners();
  }
}
