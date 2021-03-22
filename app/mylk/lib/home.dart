import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mylk/Auth.dart';
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
    // userData = Provider.of<appUser.User>(context);

    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!' + userData.uid);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.list, color: Colors.grey[800]),
              onPressed: () {
                Get.to(() => MyOrders());
              },
            ),
            IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.grey[800]),
              onPressed: () {},
            ),
          ],
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
            child: TabBarView(
                controller: tabController,
                children: [StorePage(), StorePage(), StorePage()]),
          ),

          // BottomNavigationBar(items: items)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "FAB",
        onPressed: () {},
        backgroundColor: Colors.black,
        child: Icon(Icons.shopping_cart),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
