import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/Cart_provider.dart';

class SingleProductScreen extends StatefulWidget {
  final int product_id;
  late final String product_name;
  late final String DiscountValue;
  late final String product_weight;
  late final String product_weight_type;
  late final String product_small_img;
  late final String product_MRP;
  late final String cartvalue;

  SingleProductScreen({
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
  State<SingleProductScreen> createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Badge(
              position: BadgePosition.topEnd(top: 0),
              badgeContent: Text(
                Provider.of<CartCountProvider>(context, listen: true)
                    .counter
                    .toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body: Padding(
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
                  child:
                  Hero(
                    tag: "${widget.product_id}",
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/ph.png',
                      image:  widget.product_small_img,
                    ),
                  ),
                ),
                //Center(child: Image.network(product_small_img,fit: BoxFit.contain)),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Chip(
                      backgroundColor: Colors.deepOrange,
                      label: widget.DiscountValue == ""
                          ? const Text(
                              "0% off",
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(
                              "${widget.DiscountValue}% off",
                              style: TextStyle(color: Colors.white),
                            )),
                ),
              ],
            )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product_name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [],
                ),
                Chip(
                  backgroundColor: Colors.green,
                  label: Text(
                    "${widget.product_weight}${widget.product_weight_type}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          "₹${widget.product_MRP}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                  ],
                ),
              ],
            )),
            Provider.of<CartCountProvider>(context, listen: true)
                        .ProductWishCartValue[widget.product_id] ==
                    null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        onPressed: () {
                          Provider.of<CartCountProvider>(context, listen: false)
                              .incrementCart(widget.product_id);
                        },
                        child: Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )),
                  )
                : Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {
                                Provider.of<CartCountProvider>(context,
                                        listen: false)
                                    .decrementCart(widget.product_id);
                              },
                              icon: Icon(Icons.remove)),
                          Text(Provider.of<CartCountProvider>(context,
                                  listen: true)
                              .ProductWishCartValue[widget.product_id]
                              .toString()),
                          IconButton(
                              onPressed: () {
                                Provider.of<CartCountProvider>(context,
                                        listen: false)
                                    .incrementCart(widget.product_id);
                              },
                              icon: Icon(Icons.add))
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
