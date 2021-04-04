import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:mylk/Auth.dart';
import 'package:mylk/Login.dart';
import 'package:mylk/about.dart';
import 'package:mylk/admin/adminHome.dart';
import 'package:mylk/cart.dart';
import 'package:mylk/models/userModel.dart' as appUser;
import 'package:mylk/myOrders.dart';
import 'package:mylk/report.dart';

import 'package:mylk/storePage.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    tabController = TabController(length: 4, vsync: this);
  }

  appUser.User userData;

  @override
  Widget build(BuildContext context) {
    const icon1 = Icon(Icons.drive_eta);
    final action = () async {
      print('IconButton of  tapped.');
      return true;
    };
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else if (user.phoneNumber == '+918888888888') {
        saveUserPhone(user);
        Get.to(() => AdminHome());
      } else {
        saveUserPhone(user);
        print('User is signed in!' + user.uid);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                  'assets/images/logo.png',
                )),
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('My Orders',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      )),
                  Icon(Entypo.documents)
                ],
              ),
              onTap: () {
                Get.to(() => MyOrders());
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('My Cart',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      )),
                  Icon(MaterialCommunityIcons.cart_outline),
                ],
              ),
              onTap: () {
                Get.to(() => Cart());

                // Update the state of the app
                // ...
                // Then close the drawer
              },
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('About',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      )),
                  Icon(Feather.help_circle)
                ],
              ),
              onTap: () {
                Get.to(() => About());
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Report',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      )),
                  Icon(
                    AntDesign.exclamationcircleo,
                    size: 22,
                  )
                  // Icon(Octicons.report)
                ],
              ),
              onTap: () {
                Get.to(() => SubmitReport());
              },
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Logout',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      )),
                  Icon(Icons.logout)
                ],
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.to(() => Login());

                // Update the state of the app
                // ...
                // Then close the drawer
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF545D68)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Store",
          style: TextStyle(color: Colors.grey[800]),
        ),
      ),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 0),
        children: <Widget>[
          SizedBox(
            height: 0,
          ),

          TabBar(
              controller: tabController,
              indicatorColor: Colors.grey[100],
              labelColor: Colors.black,
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 50.0, left: 40),
              unselectedLabelColor: Color(0xFFCDCDCD),
              tabs: [
                Tab(
                  child: Text('Milk',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 18.0,
                      )),
                ),
                Tab(
                  child: Text('Dahi ',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 18.0,
                      )),
                ),
                Tab(
                  child: Text('Others ',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 18.0,
                      )),
                ),
                Tab(
                  child: Text('Subscriptions ',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 18.0,
                      )),
                ),
              ]),
          Container(
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: TabBarView(controller: tabController, children: [
              // StorePage(category: 'al l'),
              StorePage(category: 'milk'),
              StorePage(category: 'dahi'),
              StorePage(category: 'others'),
              StorePage(category: 'subscription')
            ]),
          ),

          // BottomNavigationBar(items: items)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "FAB",
        onPressed: () {
          Get.to(() => Cart());
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.shopping_cart),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  saveUserPhone(User user) async {
    String phone;
    var profile = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    phone = profile.data()['phone'] ?? "";
    if (phone == "") {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({'phone': user.phoneNumber}, SetOptions(merge: true));
    }
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }
}
