import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

Future<bool> userNotification({String title, String body, String fcm}) async {
  // var profile =
  //     await FirebaseFirestore.instance.collection('users').doc(uid).get();
  var keys =
      await FirebaseFirestore.instance.collection('global').doc('admin').get();
  String key = keys['key'];

  try {
    // var fcm = profile['fcm'];
    String postUrl = "https://fcm.googleapis.com/fcm/send";
    final data = {
      "registration_ids": [fcm],
      "collapse_key": "type_a",
      "notification": {
        "title": title,
        "body": body,
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': "key=" + key // 'key=YOUR_SERVER_KEY'
    };

    var response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('Notification sent successfully');
      return true;
    } else {
      print(' CFM error in sending notification' + response.body.toString());
      // on failure do sth
      return false;
    }
  } catch (e) {
    debugPrint("Notification to user FAILED!!!!");
    return false;
  }
}

Future<bool> SendNotification(String title, String body) async {
  // var keys =
  //     await FirebaseFirestore.instance.collection('global').doc('admin').get();
  // List<String> userToken = [keys['fcm'].toString()];

  var keys =
      await FirebaseFirestore.instance.collection('global').doc('admin').get();
  List<dynamic> fcms = keys['fcms'];

  print('ADMIN FCMS ARE : !!! : ' + keys.data()['fcms'].toString());

  String postUrl = "https://fcm.googleapis.com/fcm/send";
  final data = {
    "registration_ids": fcms,
    "collapse_key": "type_a",
    "notification": {
      "title": title,
      "body": body,
    }
  };

  final headers = {
    'content-type': 'application/json',
    'Authorization':
        "key=" + keys.data()['key'].toString() // 'key=YOUR_SERVER_KEY'
  };

  var response = await http.post(Uri.parse(postUrl),
      body: json.encode(data),
      encoding: Encoding.getByName('utf-8'),
      headers: headers);

  if (response.statusCode == 200) {
    // on success do sth
    print('test ok push CFM');
    return true;
  } else {
    print(' CFM error' + response.body.toString());
    // on failure do sth
    return false;
  }
}
