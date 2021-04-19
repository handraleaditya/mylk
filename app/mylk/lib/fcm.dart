import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';

class Fcm extends StatefulWidget {
  Fcm({
    Key key,
    @required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  _FcmState createState() => _FcmState();
}

class _FcmState extends State<Fcm> {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static int i = 0;

  @override
  void initState() {
    super.initState();
    i = 0;
    // _initPermission();
    _initLocalNotifications();
    _initFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  // Future<dynamic> _initPermission() async {
  //   await Permission.notification.request();
  // }

  Future<dynamic> _initLocalNotifications() async {
    print('herebc');
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future<dynamic> _initFirebaseMessaging() async {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    debugPrint((await FirebaseMessaging.instance.getToken()).toString());
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage remoteMessage) {
        debugPrint('Onmessage Executed');
        Map<String, dynamic> message = remoteMessage.data;
        debugPrint(message.toString());
        showNotification(message);
        return;
      },
    );
  }

  static Future<dynamic> myBackgroundMessageHandler(
      RemoteMessage remoteMessage) {
    Map<String, dynamic> message = remoteMessage.data;
    debugPrint('Background Message Handler Called');
    debugPrint(message.toString());
    showNotification(message);
    return Future<void>.value();
  }

  Future<void> selectNotification(String payload) async {
    debugPrint('Callback Executed');
    i = 0;
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<dynamic> showNotification(Map<dynamic, dynamic> message) async {
    debugPrint(message.toString());
    final BigTextStyleInformation style = BigTextStyleInformation(
      message['body'],
      contentTitle: message['title'],
    );
    final AndroidNotificationDetails android = AndroidNotificationDetails(
      message['channelID'],
      message['channelName'],
      message['channelDescription'],
      when: message['timeStamp'] == null
          ? DateTime.now().millisecondsSinceEpoch
          : int.parse(message['timeStamp']),
      priority: Priority.max,
      importance: Importance.max,
      styleInformation: style,
      channelShowBadge: true,
      playSound: true,
      enableLights: true,
      enableVibration: true,
      // largeIcon:
      //     DrawableResourceAndroidBitmap('@mipmap/ic_launcher_notification')
    );
    final IOSNotificationDetails iOS = IOSNotificationDetails();
    final NotificationDetails platform =
        NotificationDetails(android: android, iOS: iOS);
    try {
      debugPrint('Showing Notification');
      await _flutterLocalNotificationsPlugin.show(
          i, message['title'], message['body'], platform);
      i++;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
