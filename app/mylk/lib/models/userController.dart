import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mylk/models/userModel.dart';

class UserController {
  final String uid;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  UserController({this.uid});

  Future<dynamic> addUserData({Map<String, dynamic> data}) async {
    data['updatedAt'] ??= DateTime.now();
    // data['createdAt'] ??= DateTime.now();

    try {
      return await userCollection.doc(uid).set(data, SetOptions(merge: true));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// called on  enter name appears
  Future<dynamic> addInitialUserData({User user}) async {
    DateTime dateTime = DateTime.now();
    await addUserData(data: {
      'name': user.name,
      'address1': user.address1,
      'address2': user.address2,
      'mobile': user.mobile,
      'updatedAt': user.updatedAt,
      'createdAt': user.createdAt
    });
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() ?? {};
    data['uid'] = uid;
    return User.fromJson(data);
  }

  Stream<User> get userData {
    if (uid == null || uid == 'loading') {
      return null;
    }
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
