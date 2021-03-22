import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mylk/Auth.dart';
import 'package:mylk/Login.dart';
import 'package:get/get.dart';
import 'package:mylk/models/userController.dart';
import 'package:mylk/models/userModel.dart' as appUser;

import 'package:mylk/utils/AuthWrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(home: Login()));
}

class MylkApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthController().user,
      child: Consumer<User>(
          builder: (BuildContext context, User user, Widget child) {
        return MultiProvider(
          providers: [
            StreamProvider<appUser.User>.value(
                value: UserController(uid: user?.uid).userData),
            Provider<AuthController>(
              create: (_) => AuthController(),
            ),
            StreamProvider(
              create: (context) => context.read<AuthController>().authState,
            )
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Rajveer Milk',
              home: Wrapper()),
        );
      }),
    );
  }
}
