import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mylk/Login.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(home: Login()));
}

class MylkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      // home: ,
    );
  }
}
