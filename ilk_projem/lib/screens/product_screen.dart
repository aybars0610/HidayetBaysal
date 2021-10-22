import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = "/proj";
  @override
  Widget build(BuildContext context) {
    Color c = const Color(0xFFa90600);
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        backgroundColor: c,
      ),
      body: Container(
        child: Center(
          child: Text("Products"),
        ),
      ),
    );
  }
}
