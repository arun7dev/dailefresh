import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// class CartValue extends StatefulWidget {
//   const CartValue({Key? key}) : super(key: key);
//
//   @override
//   State<CartValue> createState() => _CartValueState();
//
// }
//
// // class _CartValueState extends State<CartValue> {
// //
// //   void loadProducList () async {
// //
// //     var res = await http.get (Uri.parse("http://pg.dailefresh.com/WebApi/ListProductByCategoryorSubCategory_Page?Cat=FNV&Sub=FV&StoreId=1&User_id=1&R_Number=1") );
// //     if (res.statusCode == 200){
// //       var jsonData= jsonDecode (res.body) ;
// //       setState(() {
// //         _products= jsonData['Data'];
// //         _loading=false;
// //       });
// //
// //     }
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container();
// //   }
// // }


class CartCountProvider extends ChangeNotifier {

  var ProductWishCartValue = {};



  int _counter = 0;

  int get counter => _counter;

  void incrementCart(productid) {
    if(ProductWishCartValue[productid]==null){
      ProductWishCartValue[productid]=1.toString();
    }else{
      print(ProductWishCartValue[productid]);
      int a=int.parse(ProductWishCartValue[productid]);
      ++a;
      ProductWishCartValue[productid]=a.toString();


    }

    _counter++;
    notifyListeners();

  }


  void decrementCart(productid) {
    if(ProductWishCartValue[productid]=='1'){
      ProductWishCartValue[productid]=null;
    }else{
      print(ProductWishCartValue[productid]);
      int a=int.parse(ProductWishCartValue[productid]);
      --a;
      ProductWishCartValue[productid]=a.toString();


    }

    _counter--;
    notifyListeners();

  }
}
