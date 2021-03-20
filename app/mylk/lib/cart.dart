import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:mylk/models/models.dart';

class Cart extends StatelessWidget {
  // var imageUrl, price, name, description;
  Item item;
  FlutterCart cart = FlutterCart();

  Cart();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('My Cart',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
      ),
      body: ListView(children: [
        SizedBox(height: 15.0),
      ]),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Color(0xFFF17532),
      //   child: Icon(Icons.fastfood),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
