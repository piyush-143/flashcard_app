import 'package:flutter/material.dart';

class IndexProvider with ChangeNotifier {
  int _idx = 0;
  int get idx => _idx;
  void updateIdx(int currIdx) {
    _idx = currIdx;
    notifyListeners();
  }
}
