import 'package:flutter/material.dart';

class NumberModel extends ChangeNotifier{

  int _number= 0;

  void addNumber(){
    _number++;
    notifyListeners();
  }

  void reduceNumber(){
    _number--;
    notifyListeners();
  }

  int get number => _number;
}