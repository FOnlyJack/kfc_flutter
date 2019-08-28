import 'package:flutter/material.dart';

class ChangeNotifiBean with ChangeNotifier {
  double _scrollStartValue = 0.0;
  double _scrollEndValue = 1.0;

  bool _isEdge = true;
  int _takeawayIndex = 0;

  int get takeawayIndex => _takeawayIndex;

  set takeawayIndex(int value) {
    _takeawayIndex = value;
    notifyListeners();
  }

  set isEdge(bool value) {
    _isEdge = value;
    notifyListeners();
  }

  bool get isEdge => _isEdge;

  double get scrollEndValue => _scrollEndValue;

  set scrollEndValue(double value) {
    _scrollEndValue = value;
    notifyListeners();
  }

  double get scrollStartValue => _scrollStartValue;

  set scrollStartValue(double value) {
    _scrollStartValue = value;
    notifyListeners();
  }
}
