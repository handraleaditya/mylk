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
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> loadFromFuture() async {
    // <fetch data from server. ex. login>

    return Future.value(new Login());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new Login(),
        image: new Image.asset(
          'assets/images/logo.png',
        ),
        // loadingText: Text("Loading"),
        photoSize: 250.0,
        useLoader: false,
        // loaderColor: Colors.blue,
      ),
    );
  }
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
