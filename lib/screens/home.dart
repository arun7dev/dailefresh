import 'package:badges/badges.dart';
import 'package:dailefresh/provider/Cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
      drawer:  const Drawer(
        child: Center(child: Text('dailefresh')),
      ),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        leading:  IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        centerTitle:true,
        title: const Text("dailefresh"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:20),
            child: Badge(
              position: BadgePosition.topEnd(top: 0),
              badgeContent: Text(Provider.of<CartCountProvider>(context,listen: true).counter.toString(),style: TextStyle(color: Colors.white),),
              child: Icon(Icons.shopping_cart),
            ),
          )
        ],
      ),
      body:_products.isNotEmpty?
      GridView.builder(
        itemCount: _products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          childAspectRatio: 3/4
        ),
        itemBuilder: (BuildContext context, int index){
          //return ProductCard(products: _products[index]);
          return ProductCard(
              product_id: _products[index]['product_id'],
              product_name: _products[index]['product_name'],
              DiscountValue:_products[index]['DiscountValue'],
              product_weight: _products[index]['PriceList'][0]['product_weight'],
              product_weight_type: _products[index]['PriceList'][0]['product_weight_type'],
              product_small_img:_products[index]['product_small_img'],
              product_MRP: _products[index]['PriceList'][0]['product_MRP'],
            cartvalue: 0.toString(),
          );
        },
      )
          :Center(
        child: _loading?const Center(child: CircularProgressIndicator()):Text("Sorry nothing to view")
      ),
    );
  }

  void loadProducList () async {
    setState(() {
      _loading=true;
    });
    var res = await http.get (Uri.parse("http://pg.dailefresh.com/WebApi/ListProductByCategoryorSubCategory_Page?Cat=FNV&Sub=FV&StoreId=1&User_id=1&R_Number=1") );
    if (res.statusCode == 200){
      var jsonData= jsonDecode (res.body) ;
      setState(() {
        _products= jsonData['Data'];
        _loading=false;
      });

    }
  }
}

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
    print(Provider.of<CartCountProvider>(context,listen: false).ProductWishCartValue[product_id].toString());
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        child: Column(

          children: [
            Row(children: [],),
            Expanded(child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  child: Text(""),
                ),
                Center(child: Image.network(product_small_img,fit: BoxFit.contain)),
                Positioned(
                    top: 0,
                    left: 0,
                  child: Chip(
                      backgroundColor:Colors.deepOrange,
                    label:DiscountValue==""?const Text("0% off",style: TextStyle(color: Colors.white),): Text("${DiscountValue}% off",style: TextStyle(color: Colors.white),)),),

                  ],
               )),
            Expanded(child:Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Text(product_name,style: TextStyle(fontWeight: FontWeight.bold),),
                Row(children: [],),
                Chip(
                  backgroundColor:Colors.green,
                  label:  Text("${product_weight}${product_weight_type}",style: TextStyle(color: Colors.white),),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Expanded(
                      flex:1,
                child: Text("₹${product_MRP}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                  Expanded(
                    flex:3,
                    child: Provider.of<CartCountProvider>(context,listen: false).ProductWishCartValue[product_id]==null?
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: OutlinedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                          ),
                          onPressed: (){
                              Provider.of<CartCountProvider>(context,listen: false).incrementCart(product_id);

                          },
                          child: Text("Add",style: TextStyle(color: Colors.black,),)),
                    ):Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(onPressed: (){
                              Provider.of<CartCountProvider>(context,listen: false).decrementCart(product_id);
                            }, icon: Icon(Icons.remove)),
                            Text( Provider.of<CartCountProvider>(context,listen: false).ProductWishCartValue[product_id].toString()),
                            IconButton(onPressed: (){

                              Provider.of<CartCountProvider>(context,listen: false).incrementCart(product_id);

                            }, icon: Icon(Icons.add))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
