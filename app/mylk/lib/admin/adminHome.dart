import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:mylk/Login.dart';
import 'package:mylk/admin/allOrders.dart';
import 'package:mylk/cart.dart';
import 'package:mylk/admin/allUsers.dart';
import 'package:mylk/admin/reports.dart';

import 'package:mylk/myOrders.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    _saveDeviceToken();
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF545D68)),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Admin",
            style: TextStyle(color: Colors.grey[800]),
          )),
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
                  Text('All Orders',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      )),
                  Icon(Entypo.documents)
                ],
              ),
              onTap: () {
                Get.to(() => AllOrders());
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
                  Text('All users',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      )),
                  Icon(Feather.users)
                ],
              ),
              onTap: () {
                Get.to(() => AllUsers());

                // Update the state of the app
                // ...
                // Then close the drawer
              },
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('All Reports',
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
                Get.to(() => Reports());

                // Update the state of the app
                // ...
                // Then close the drawer
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
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Card(
                child: InkWell(
                  onTap: () {
                    Get.to(() => AllOrders());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "All Orders",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.normal),
                              ),
                              Icon(Entypo.documents)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Card(
                child: InkWell(
                  onTap: () {
                    Get.to(() => AllUsers());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "All Users",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.normal),
                              ),
                              Icon(Feather.users),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Card(
                child: InkWell(
                  onTap: () {
                    Get.to(() => Reports());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "All Reports",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.normal),
                              ),
                              Icon(AntDesign.exclamationcircleo),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<String> getTotalUsers() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .length
        .toString();
  }

  _saveDeviceToken() async {
    String uid = _auth.currentUser.uid;

    // Get the token for this device
    String fcmToken;

    try {
      fcmToken = await _fcm.getToken();
    } catch (e) {
      print(e);
    }
    print('succdess ' + fcmToken);
    var tokens = FirebaseFirestore.instance.collection('global').doc('admin');

    // await tokens.set({
    //   'fcm': fcmToken,
    // }, SetOptions(merge: true));
    // Save it to Firestore
    if (fcmToken != null) {
      print('FCM WAS NULL');

      var tokens = FirebaseFirestore.instance.collection('global').doc('admin');

      // await tokens.set({
      //   'fcm': fcmToken,
      // }, SetOptions(merge: true));

      await tokens.update({
        "fcms": FieldValue.arrayUnion([fcmToken])
      });
    }
  }
}
