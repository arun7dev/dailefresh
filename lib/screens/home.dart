import 'package:badges/badges.dart';
import 'package:dailefresh/provider/Cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

import '../models/SingleProduct.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<dynamic> _products = [];
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadProducList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const Drawer(
        child: Center(child: Text('dailefresh')),
      ),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        centerTitle: true,
        title: const Text("dailefresh"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Badge(
              position: BadgePosition.topEnd(top: 0),
              badgeContent: Text(
                Provider.of<CartCountProvider>(context, listen: true)
                    .counter
                    .toString(),
                style: const TextStyle(color: Colors.white),
              ),
              child: const Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body: _products.isNotEmpty
          ? GridView.builder(
              itemCount: _products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  childAspectRatio: 4/5),
              itemBuilder: (BuildContext context, int index) {
                //return ProductCard(products: _products[index]);
                return ProductCard(
                  product_id: _products[index]['product_id'],
                  product_name: _products[index]['product_name'],
                  DiscountValue: _products[index]['DiscountValue'],
                  product_weight: _products[index]['PriceList'][0]
                      ['product_weight'],
                  product_weight_type: _products[index]['PriceList'][0]
                      ['product_weight_type'],
                  product_small_img: _products[index]['product_small_img'],
                  product_MRP: _products[index]['PriceList'][0]['product_MRP'],
                  cartvalue: 0.toString(),
                );
              },
            )
          : Center(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : const Text("Sorry nothing to view")),
    );
  }

  void loadProducList() async {
    setState(() {
      _loading = true;
    });
    var res = await http.get(Uri.parse(
        "http://pg.dailefresh.com/WebApi/ListProductByCategoryorSubCategory_Page?Cat=FNV&Sub=FV&StoreId=1&User_id=1&R_Number=1"));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      setState(() {
        _products = jsonData['Data'];
        _loading = false;
      });
    }
  }
}
