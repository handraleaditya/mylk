import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:mylk/Auth.dart';
import 'package:mylk/models/itemController.dart';
import 'package:mylk/models/itemModel.dart';
import 'package:mylk/models/orderController.dart';
import 'package:mylk/models/orderModel.dart';
import 'package:mylk/models/userModel.dart' as appUser;
import 'package:mylk/models/userController.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  MyOrders();

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    super.initState();
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
              onPressed: () {},
            )
          ],
          title: Text('My Orders',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 20.0,
                  color: Color(0xFF545D68))),
        ),
        body: Container(
          child: FutureBuilder(
              future: getOrders(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  if (!snapshot.hasData) {
                    print('yay');
                  }
                  // if (cart.cartItem.length == 0) {
                  //   return Center(
                  //       child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Container(
                  //           height: 100,
                  //           child: Image(
                  //               image: AssetImage(
                  //             'assets/images/cart.png',
                  //           ))),
                  //       Text("No Orders Yet :("),
                  //     ],
                  //   ));
                  // }
                  return Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          padding:
                              EdgeInsets.only(left: 10, right: 10, top: 50),
                          itemCount: 1,
                          itemBuilder: (_, index) {
                            Text(
                              "fddfdf",
                              style: TextStyle(color: Colors.red),
                            );
                          }),
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
                            onTap: () {},
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
      },
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(25.0),
      ),
    );
  }

  // void placeOrder() async {
  //   List<Item> items = await getCartItems();
  //   User user = await FirebaseAuth.instance.currentUser;

  //   Order order = Order(items, cart.getTotalAmount(), "placed", item.reference);
  //   print(order);
  //   OrderController orderController = OrderController();
  //   orderController.add(order);

  //   for (item in items) {
  //     // print(item);
  //     // itemController.add(item);
  //   }

  //   print(items.first.imageUrl);
  // }

  Future getOrders() async {
    List<Item> items = List<Item>();
    Item item = Item('hi');
    items.add(item);

    OrderController orderController = OrderController();
    List<Order> orders = orderController.getOrders();
    print('EMPTYx+' + orders.toString());
    return orders;

    // for (var item in cartItems) {
    //   snapshot = await FirebaseFirestore.instance
    //       .collection('items')
    //       .doc(item.productId)
    //       .get();

    //   Item newItem = Item.fromSnapshot(snapshot);
    //   newItem.quantity = item.quantity;
    //   items.add(newItem);

    //   print('DATA!!! ' + newItem.name);
    // }
    // Item x = Item.fromJson(snapshot.data[]);
    // }
    return items;
  }
}
