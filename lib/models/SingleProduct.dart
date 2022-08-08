import 'package:dailefresh/screens/SingleProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/Cart_provider.dart';

class ProductCard extends StatelessWidget {
  final int product_id;
  late final String product_name;
  late final String DiscountValue;
  late final String product_weight;
  late final String product_weight_type;
  late final String product_small_img;
  late final String product_MRP;
  late final String cartvalue;

  ProductCard({
    required this.product_id,
    required this.product_name,
    required this.DiscountValue,
    required this.product_weight,
    required this.product_weight_type,
    required this.product_small_img,
    required this.product_MRP,
    required this.cartvalue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleProductScreen(
                      product_id: product_id,
                      product_name: product_name,
                      DiscountValue: DiscountValue,
                      product_weight: product_weight,
                      product_weight_type: product_weight_type,
                      product_small_img: product_small_img,
                      product_MRP: product_MRP,
                      cartvalue: cartvalue,
                    )));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [],
              ),
              Expanded(
                  child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: Text(""),
                  ),
                  Center(
                    child: Hero(
                      tag: "$product_id",
                      child:
                      FadeInImage.assetNetwork(
                        placeholder: 'assets/ph.png',
                        image:  product_small_img,
                      ),

                    ),
                  ),
                  //Center(child: Image.network(product_small_img,fit: BoxFit.contain)),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Chip(
                        backgroundColor: Colors.deepOrange,
                        label: DiscountValue == ""
                            ? const Text(
                                "0% off",
                                style: TextStyle(color: Colors.white),
                              )
                            : Text(
                                "${DiscountValue}% off",
                                style: TextStyle(color: Colors.white),
                              )),
                  ),
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    product_name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [],
                  ),
                  Chip(
                    backgroundColor: Colors.green,
                    label: Text(
                      "${product_weight}${product_weight_type}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Text(
                            "₹${product_MRP}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                      Expanded(
                        flex: 3,
                        child: Provider.of<CartCountProvider>(context,
                                        listen: false)
                                    .ProductWishCartValue[product_id] ==
                                null
                            ? Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: OutlinedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0,))),
                                    ),
                                    onPressed: () {
                                      Provider.of<CartCountProvider>(context,
                                              listen: false)
                                          .incrementCart(product_id);
                                    },
                                    child: const Text(
                                      "Add",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    )),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                child: Container(
                                  width: 50,
                                  height: 40,
                                  child: AspectRatio(
                                    aspectRatio: 2/1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Provider.of<CartCountProvider>(
                                                        context,
                                                        listen: false)
                                                    .decrementCart(product_id);
                                              },
                                              icon: Icon(Icons.remove)),
                                          Text(Provider.of<CartCountProvider>(
                                                  context,
                                                  listen: false)
                                              .ProductWishCartValue[product_id]
                                              .toString()),
                                          IconButton(
                                              onPressed: () {
                                                Provider.of<CartCountProvider>(
                                                        context,
                                                        listen: false)
                                                    .incrementCart(product_id);
                                              },
                                              icon: Icon(Icons.add))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
