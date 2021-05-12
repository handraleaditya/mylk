import 'package:firebase_auth/firebase_auth.dart';

/// Flutter code sample for RadioListTile

// ![RadioListTile sample](https://flutter.github.io/assets-for-api-docs/assets/material/radio_list_tile.png)
//
// This widget shows a pair of radio buttons that control the `_character`
// field. The field is of the type `SingingCharacter`, an enum.

import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';
import 'package:mylk/models/orderController.dart';
import 'package:mylk/models/orderModel.dart';
import 'package:mylk/myOrders.dart';
import 'package:mylk/utils/notification.dart';

/// This is the main application widget.
class PaymentMethod extends StatefulWidget {
  Order order;
  PaymentMethod({Key key, this.order}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          title: Text('Payment Method (2/2)',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 18.0,
                  color: Color(0xFF545D68))),
        ),
        body: PaymentMethodWidget(order: widget.order),
      ),
    );
  }
}

enum SingingCharacter { Cash_on_delivery, Card_payment }

/// This is the stateful widget that the main application instantiates.
class PaymentMethodWidget extends StatefulWidget {
  Order order;
  PaymentMethodWidget({Key key, this.order}) : super(key: key);

  @override
  _PaymentMethodWidgetState createState() => _PaymentMethodWidgetState();
}

/// This is the private State class that goes with PaymentMethodWidget.
class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  SingingCharacter _character = SingingCharacter.Cash_on_delivery;

  void placeOrder(Order order) {
    User user = FirebaseAuth.instance.currentUser;

    OrderController orderController = OrderController(uid: user.uid);
    orderController.add(order);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          'Note : Store timings are 8 AM to 7 PM',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        RadioListTile<SingingCharacter>(
          title: const Text('Cash on delivery'),
          value: SingingCharacter.Cash_on_delivery,
          groupValue: _character,
          onChanged: (SingingCharacter value) {
            setState(() {
              _character = value;
            });
          },
        ),
        RadioListTile<SingingCharacter>(
          title: const Text(
            'Card Payment (coming soon)',
            style: TextStyle(color: Colors.grey),
          ),
          value: SingingCharacter.Card_payment,
          groupValue: _character,

          onChanged: (value) =>
              true ? null : value = SingingCharacter.Cash_on_delivery,

          // onChanged: (SingingCharacter value) {
          //   setState(() {
          //     _character = value;
          //   });
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ProceedButton(widget.order),
        ),
      ],
    );
  }

  Widget ProceedButton(Order order) {
    FlutterCart cart = FlutterCart();

    return RaisedButton(
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
      textColor: Colors.white,
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Confirm Order"),
          Icon(Icons.check_circle, color: Colors.green),
        ],
      ),
      onPressed: () async {
        placeOrder(order);
        SendNotification(
            'Yay! New order placed!',
            "Rs." +
                order.total.toInt().toString() +
                " order placed, please check inside the app.");
        cart.deleteAllCart();
        Get.to(() => MyOrders());
      },
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(25.0),
      ),
    );
  }
}
