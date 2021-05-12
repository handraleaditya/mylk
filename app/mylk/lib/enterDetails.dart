import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mylk/models/orderController.dart';
import 'package:mylk/models/orderModel.dart';
import 'package:mylk/models/userController.dart';
import 'package:mylk/myOrders.dart';
import "package:firebase_messaging/firebase_messaging.dart";
import 'package:mylk/paymentMethod.dart';
// import 'package:dio/dio.dart';

class EnterDetails extends StatefulWidget {
  Order order;
  EnterDetails({
    Key key,
    this.order,
  }) : super(key: key);
  @override
  _EnterDetailsState createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  final _formKey = GlobalKey<FormState>();
  User user = FirebaseAuth.instance.currentUser;

  String name, address, address2, note, mobile2;

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController mobile2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = name;
    addressController.text = address;
    mobile2Controller.text = mobile2;

    address2Controller.text = address2;

    return Scaffold(
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
          title: Text('Enter your details (1/2)',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 20.0,
                  color: Color(0xFF545D68))),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[100]),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: "Name",
                          prefixIcon: IconTheme(
                            child: Icon(FontAwesome.user),
                            data: IconThemeData(color: Colors.grey[800]),
                          )),
                      onTap: () {},
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 100,
                      child: TextFormField(
                        maxLines: 5,
                        autofocus: true,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey[100]),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            hintText: "Address line 1",
                            contentPadding: EdgeInsets.all(10),
                            isDense: true,
                            prefixIcon: IconTheme(
                              child: Icon(FontAwesome.building),
                              data: IconThemeData(color: Colors.grey[800]),
                            )),
                        controller: addressController,
                        onTap: () {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autofocus: true,
                      inputFormatters: [
                        // FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[100]),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: "Address line 2 (optional)",
                          prefixIcon: IconTheme(
                            child: Icon(FontAwesome.building_o),
                            data: IconThemeData(color: Colors.grey[800]),
                          )),
                      controller: address2Controller,
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    TextField(
                      maxLines: 1,
                      autofocus: true,
                      inputFormatters: [
                        // FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[100]),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: "Whatsapp no. (optional)",
                          prefixIcon: IconTheme(
                            child: Icon(FontAwesome.whatsapp),
                            data: IconThemeData(color: Colors.grey[800]),
                          )),
                      controller: mobile2Controller,
                      onTap: () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                          "Note : Please enter you whatsapp number for getting bill",
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[500])),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      maxLines: 1,
                      autofocus: true,
                      inputFormatters: [
                        // FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[100]),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: "Note (optional)",
                          prefixIcon: IconTheme(
                            child: Icon(FontAwesome.sticky_note_o),
                            data: IconThemeData(color: Colors.grey[800]),
                          )),
                      controller: noteController,
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    ProceedButton(),
                    // Add TextFormFields and ElevatedButton here.
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget ProceedButton() {
    return RaisedButton(
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 30, right: 30),
      textColor: Colors.white,
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Proceed to payment"),
          Icon(Icons.chevron_right),
        ],
      ),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          updateAddress();
          // placeOrder(widget.order);
          Order finalOrder = await buildOrder(widget.order);
          Get.to(() => PaymentMethod(order: finalOrder));
        }
      },
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(25.0),
      ),
    );
  }

  void getDetails() async {
    DocumentSnapshot profile = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    setState(() {
      name = profile.data()['name'];
      address = profile.data()['address'];
      address2 = profile.data()['address2'];
      mobile2 = profile.data()['mobile2'];
    });
  }

  void updateAddress() {
    UserController userController = UserController(uid: user.uid);
    Map<String, dynamic> data = {
      'name': nameController.text,
      'address': addressController.text,
      'address2': address2Controller.text,
      'mobile2': mobile2Controller.text,
    };
    userController.addUserData(data: data);
  }

  Future<Order> buildOrder(Order order) async {
    order.address = addressController.text;
    order.address2 = address2Controller.text;
    order.name = nameController.text;
    order.note = noteController.text;

    order.mobile2 = mobile2Controller.text;

    order.phone = await getPhone();

    return order;

    // sendNotification(order);
  }

//   static Future<void> sendNotification(Order order) async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//     String key =
//         "	AAAAQTmwWqo:APA91bGCnybc4-bPYYz3TGd53LjdkyGX4hAYmCC4T9mfF-VwA9fwjILAbKrHRhkiIhskUEVl2rPOcftvISPRP3rnmZ5uArKpV--U4XM-S7g_nwGcYI_ciEE2cdZ-n3RDBxAO9Q01sMCz";
//     var postUrl = "fcm.googleapis.com/fcm/send";

//     var doc = await FirebaseFirestore.instance
//         .collection('global')
//         .doc('admin')
//         .get();
//     var token = doc['fcm'];
//     print('token : $token');

//     final data = {
//       "notification": {
//         "body": "Accept Ride Request",
//         "title": "This is Ride Request"
//       },
//       "priority": "high",
//       "data": {
//         "click_action": "FLUTTER_NOTIFICATION_CLICK",
//         "id": "1",
//         "status": "done"
//       },
//       "to": "$token"
//     };

//     final headers = {
//       'content-type': 'application/json',
//       'Authorization':
//           'key=<Your firebase Messaging Api Key Get it from firebase project settings under cloud messaging section>'
//     };
//     print('token waiting : $token');

//     BaseOptions options = new BaseOptions(
//       connectTimeout: 5000,
//       receiveTimeout: 3000,
//       headers: headers,
//     );

//     print('Request Sent To Driver');

//     // try {
//     //   final response = await Dio(options).post(postUrl, data: data);

//     //   if (response.statusCode == 200) {
//     //     print('Request Sent To Driver');
//     //   } else {
//     //     print('notification sending failed');
//     //     // on failure do sth
//     //   }
//     // } catch (e) {
//     //   print('exception hep $e');
//     // }
//   }
// }

  Future<String> getPhone() async {
    User currentUser = await FirebaseAuth.instance.currentUser;
    print('Phone number was ' + currentUser.phoneNumber.toString());
    return currentUser.phoneNumber;
  }
}
