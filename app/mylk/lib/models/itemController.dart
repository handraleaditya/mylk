// import 'dart:html';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mylk/models/itemModel.dart';
// import 'package:deciml/backend/item/itemProviderModel.dart';
// import 'package:deciml/backend/services/cloudFunction.dart';

class ItemController {
  String id;
  String name, description;
  num price;
  Item item;

  ItemController({@required this.id});

  Future<String> add(Item item) async {
    // item.createdAt = DateTime.now() as String;

    // if (isLoggedIn()) {
    if (true) {
      await FirebaseFirestore.instance
          .collection('items')
          .add(item.toJson())
          .catchError((e) {
        print(e);
      });
    }

    // return "";
  }

  getProducts() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("items").get();

    // FirebaseFirestore.instance.collection('items').snapshots().map();
  }

  // Future<dynamic> update(ItemModel item, String id) async {
  //   try {
  //     item.createdAt = DateTime.now() as String;
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(uid)
  //         .collection('items')
  //         .doc(id)
  //         .set(item.toMap(), SetOptions(merge: true));
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // Future<dynamic> delete(String id) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(uid)
  //         .collection('items')
  //         .doc(id)
  //         .delete();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // itemProvider _itemsFromDocumentSnapshot(QuerySnapshot snapshot) {
  //   Map<String, item> itemList = {};
  //   for (QueryDocumentSnapshot item in snapshot.docs) {
  //     itemList[item.id] = item.fromMap(item.data());
  //   }
  //   return itemProvider(items: itemList);
  // }

  // Stream<itemProvider> get itemList {
  //   if (uid == null) {
  //     return null;
  //   }
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uid)
  //       .collection('items')
  //       .snapshots()
  //       .map(_itemsFromDocumentSnapshot);
  // }
}
