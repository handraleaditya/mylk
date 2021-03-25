import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';
import 'package:mylk/Auth.dart';
import 'package:mylk/enterDetails.dart';
import 'package:mylk/home.dart';
import 'package:mylk/models/itemController.dart';
import 'package:mylk/models/itemModel.dart';
import 'package:mylk/models/orderController.dart';
import 'package:mylk/models/orderModel.dart';
import 'package:mylk/models/userModel.dart' as appUser;
import 'package:mylk/models/userController.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  Cart();

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  Item item;
  AuthController auth = AuthController();
  FlutterCart cart = FlutterCart();
  var cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = cart.cartItem;
  }

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
          actions: [
            IconButton(
              icon: Icon(Icons.remove_shopping_cart, color: Color(0xFF545D68)),
              onPressed: () {
                cart.deleteAllCart();
                setState(() {
                  cartItems = cart.cartItem;
                });
              },
            )
          ],
          title: Text('My Cart',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 20.0,
                  color: Color(0xFF545D68))),
        ),
        body: Container(
          child: FutureBuilder(
              future: getCartItems(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else {
                  if (cart.cartItem.length == 0) {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 100,
                            child: Image(
                                image: AssetImage(
                              'assets/images/cart.png',
                            ))),
                        Text("Cart is empty"),
                      ],
                    ));
                  }
                  return Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 50),
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            return cartItem(item = snapshot.data[index]);
                          }),
                      Container(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20, top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Total  ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    "\₹" +
                                        cart
                                            .getTotalAmount()
                                            .toInt()
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: FlatButton(
                          onPressed: () {
                            cart.deleteAllCart();

                            setState(() {
                              cartItems = cart.cartItem;
                            });
                          },
                          child: Text("CLEAR CART",
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: ProceedButton()),
                      Container(
                        padding: EdgeInsets.only(top: 0),
                        child: FlatButton(
                          onPressed: () {
                            Get.to(() => Home());
                          },
                          child: Text("Browse more", style: TextStyle()),
                        ),
                      ),
                    ],
                  );
                }
              }),
        ));
  }

  Widget cartItem(Item item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 5.0)
                  ],
                  color: Colors.white),
              // decoration: BoxDecoration(
              //   border:
              //       Border(left: BorderSide(width: 7, color: Colors.grey[500])),
              // ),
              height: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 130,
                        // height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Text(
                                item.name,
                                style: TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          item.quantity.toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(
                          '\₹' + (item.price * item.quantity).toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 130,
                        // height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          // child: Icon(
                          //   Icons.close,
                          //   color: Colors.red,
                          // )
                          child: GestureDetector(
                            onTap: () {
                              int index =
                                  cart.findItemIndexFromCart(item.reference.id);
                              cart.deleteItemFromCart(index);
                              setState(() {
                                cartItems = cart.cartItem;
                              });
                            },
                            child: Text(
                              "Remove",
                              style: TextStyle(fontSize: 10, color: Colors.red),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget ProceedButton() {
    return RaisedButton(
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
      textColor: Colors.white,
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Place order"),
          Icon(Icons.check_circle, color: Colors.green),
        ],
      ),
      onPressed: () async {
        // placeOrder();
        User user = await FirebaseAuth.instance.currentUser;
        Order order = Order(
          await getCartItems(),
          cart.getTotalAmount(),
          "placed",
          item.reference,
          user.uid,
        );
        Get.to(() => EnterDetails(order: order));
      },
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(25.0),
      ),
    );
  }

  Future getCartItems() async {
    FlutterCart cart = FlutterCart();
    List<Item> items = List<Item>();
    DocumentSnapshot snapshot;
    for (var item in cartItems) {
      snapshot = await FirebaseFirestore.instance
          .collection('items')
          .doc(item.productId)
          .get();

      Item newItem = Item.fromSnapshot(snapshot);
      newItem.quantity = item.quantity;
      items.add(newItem);
    }
    // Item x = Item.fromJson(snapshot.data[]);
    // }
    return items;
  }

  Future<List<Widget>> buildCart() async {
    FlutterCart cart = FlutterCart();
    List cartPage = List<Widget>();

    // cart.deleteAllCart();
    for (var item in cartItems) {
      Item newItem = await getItemFromReference(item.productId);
      cartPage.add(cartItem(newItem));
      // cart.deleteAllCart();
      print('------ID WAS---' + item.productId);
    }
    cartPage.add(SizedBox(height: 20));
    cartPage.add(Container(
      width: 50,
      child: FlatButton(
        onPressed: () {
          cart.deleteAllCart();

          setState(() {
            cartItems = cart.cartItem;
          });
        },
        child: Text("CLEAR CART", style: TextStyle(color: Colors.red)),
      ),
    ));
    cartPage.add(SizedBox(height: 10));

    cartPage.add(ProceedButton());

    return cartPage;
  }

  Item getItemFromReference(String id) {
    var document = getItemFromDB(id);
    return document;
  }

  getItemFromDB(String id) async {
    DocumentSnapshot document =
        await FirebaseFirestore.instance.collection('items').doc(id).get();
    Item x = Item.fromJson(document.data());
    return x;
  }
}
