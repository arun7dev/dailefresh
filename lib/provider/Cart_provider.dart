import 'package:flutter/material.dart';

class CartCountProvider extends ChangeNotifier {
  var ProductWishCartValue = {};

  int _counter = 0;

  int get counter => _counter;

  void incrementCart(productid) {
    if (ProductWishCartValue[productid] == null) {
      ProductWishCartValue[productid] = 1.toString();
    } else {
      int a = int.parse(ProductWishCartValue[productid]);
      ++a;
      ProductWishCartValue[productid] = a.toString();
    }

    _counter++;
    notifyListeners();
  }

  void decrementCart(productid) {
    if (ProductWishCartValue[productid] == '1') {
      ProductWishCartValue[productid] = null;
    } else {
      print(ProductWishCartValue[productid]);
      int a = int.parse(ProductWishCartValue[productid]);
      --a;
      ProductWishCartValue[productid] = a.toString();
    }

    _counter--;
    notifyListeners();
  }
}
