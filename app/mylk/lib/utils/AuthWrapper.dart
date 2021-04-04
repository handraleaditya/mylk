import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mylk/Login.dart';
import 'package:mylk/about.dart';
import 'package:mylk/home.dart';
import 'package:mylk/main.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // User userData = Provider.of<User>(context);
    // User user = context.watch<User>();

    // await FirebaseAuth.instance.authStateChanges().listen((User user) {
    //   if (user == null) {
    //     print('User is currently signed out!111');
    //     return Login();
    //   } else {
    //     print('User is signed in!111');
    //     return Home();
    //   }
    // });

    if (loggedIn() == true) {
      return Home();
    } else {
      return Login();
    }

    // return Wrapper();
    // if (user == null) {
    //   print('USSR WAS NULL< LOGGIN IN');
    //   return Login();
    // } else if (user != null) {
    // } else
    //   return MyApp();
  }

  Future<bool> loggedIn() async {
    bool loggedIn = false;
    await FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!111');
        loggedIn = false;
      } else {
        print('User is signed in!111');
        Get.to(() => Home());
        loggedIn = true;
      }
    });
    return loggedIn;
  }
}
