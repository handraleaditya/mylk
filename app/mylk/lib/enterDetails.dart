import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mylk/models/orderController.dart';
import 'package:mylk/models/orderModel.dart';
import 'package:mylk/models/userController.dart';

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

  String name, address, address2, note;

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = name;
    addressController.text = address;
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
          actions: [
            IconButton(
              icon: Icon(Icons.remove_shopping_cart, color: Color(0xFF545D68)),
              onPressed: () {},
            )
          ],
          title: Text('Enter your details',
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
                    TextField(
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
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter your name';
                      //   }
                      //   return null;
                      // },
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
          Text("Confirm Order"),
          Icon(Icons.check_circle, color: Colors.green),
        ],
      ),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          updateAddress();
          placeOrder(widget.order);
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
    });
  }

  void updateAddress() {
    UserController userController = UserController(uid: user.uid);
    Map<String, dynamic> data = {
      'name': nameController.text,
      'address': addressController.text,
      'address2': address2Controller.text,
    };
    userController.addUserData(data: data);
  }

  void placeOrder(Order order) async {
    order.address = addressController.text;
    order.address2 = address2Controller.text;
    order.name = nameController.text;

    OrderController orderController = OrderController(uid: user.uid);
    orderController.add(order);

    // for (item in items) {
    //   // print(item);
    //   // itemController.add(item);
    // }

    // print(items.first.imageUrl);
  }
}
