import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mylk/Auth.dart';
import 'package:mylk/Login.dart';
import 'package:get/get.dart';
import 'package:mylk/models/userController.dart';
import 'package:mylk/models/userModel.dart' as appUser;

import 'package:mylk/utils/AuthWrapper.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:mylk/fcm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');

  final MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);

  await Firebase.initializeApp();
  runApp(GetMaterialApp(home: MyApp()));
}

Future selectNotification(String payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
  print('done');
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
     child: Stack(
        children: [
          SplashScreen(
            seconds: 3,
            navigateAfterSeconds: new Login(),
            // image: new Image.asset(
            //   'assets/images/logo.png',
            // ),
            // // loadingText: Text("Loading"),
            // photoSize: 250.0,
            useLoader: false,
            // loaderColor: Colors.blue,
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logo.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ],
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
              home: Fcm(child: Wrapper())),
        );
      }),
    );
  }
}
