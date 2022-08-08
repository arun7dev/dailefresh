import 'package:dailefresh/screens/home.dart';
import 'package:dailefresh/provider/Cart_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<CartCountProvider>(
      create: (context) => CartCountProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DaileFresh',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Home(),
      ),
    );
  }
}
