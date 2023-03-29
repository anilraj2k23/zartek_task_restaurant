import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier{

  int _dishCount = 0;
  int get dishCount => _dishCount;

  int _orderCount = 0;
  int get orderCount => _orderCount;

 void  incrementOrder(){
   _orderCount++;
   notifyListeners();
 }

  void  decrementOrder(){
   if(_orderCount!=0){ _orderCount--;
   notifyListeners();
   }

  }


}