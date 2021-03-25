import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:mylk/Auth.dart';
import 'package:mylk/Login.dart';
import 'package:mylk/cart.dart';
import 'package:mylk/models/userModel.dart' as appUser;
import 'package:mylk/myOrders.dart';

import 'package:mylk/storePage.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  appUser.User userData;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
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
                  Text('Help',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      )),
                  Icon(Feather.help_circle)
                ],
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
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
          )),
      body: ListView(
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
                  child: Text('All',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 20.0,
                      )),
                ),
                Tab(
                  child: Text('Milk',
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
                )
              ]),
          Container(
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: TabBarView(controller: tabController, children: [
              StorePage(category: 'all'),
              StorePage(category: 'milk'),
              StorePage(category: 'others')
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

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }
}
