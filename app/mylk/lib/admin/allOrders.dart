import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:mylk/Auth.dart';
import 'package:mylk/Login.dart';
import 'package:mylk/admin/adminHome.dart';
import 'package:mylk/admin/newOrders.dart';

import 'package:mylk/cart.dart';
import 'package:mylk/models/userModel.dart' as appUser;
import 'package:mylk/myOrders.dart';

import 'package:mylk/storePage.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/rendering.dart';

class AllOrders extends StatefulWidget {
  // final String category;
  // AllOrders({Key key,this.category}):super(key:key)

  @override
  _AllOrdersState createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  final ScrollController _scrollController = ScrollController();

  appUser.User userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

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

      appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF545D68)),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "All orders",
            style: TextStyle(color: Colors.grey[800]),
          )),
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        // padding: EdgeInsets.only(left: 0),
        children: <Widget>[
          SizedBox(
            height: 0,
          ),

          TabBar(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              indicatorColor: Colors.grey[100],
              labelColor: Colors.black,
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 50.0, left: 40),
              unselectedLabelColor: Color(0xFFCDCDCD),
              tabs: [
                Tab(
                  child: Row(
                    children: [
                      Text('New ',
                          style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 20.0,
                          )),
                    ],
                  ),
                ),
                Tab(
                  child: Text('Accepted',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 18.0,
                      )),
                ),
                Tab(
                  child: Text('Completed',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 18.0,
                      )),
                ),
                Tab(
                  child: Text('Cancelled',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 18.0,
                      )),
                )
              ]),
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: TabBarView(controller: tabController, children: [
              NewOrders(
                category: 'placed',
              ),
              NewOrders(
                category: 'accepted',
              ),
              NewOrders(
                category: 'completed',
              ),
              NewOrders(
                category: 'cancelled',
              ),
            ]),
          ),

          // BottomNavigationBar(items: items)
        ],
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
