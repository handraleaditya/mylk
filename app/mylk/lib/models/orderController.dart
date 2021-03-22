// import 'dart:html';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mylk/models/orderModel.dart';
// import 'package:deciml/backend/order/orderProviderModel.dart';
// import 'package:deciml/backend/services/cloudFunction.dart';

class OrderController {
  String id;
  String name, description;
  num price;
  Order order;

  OrderController();

  Future<String> add(Order order) async {
    // order.createdAt = DateTime.now() as String;

    // if (isLoggedIn()) {
    if (true) {
      try {
        await FirebaseFirestore.instance
            .collection('orders')
            // .add(order.toJson())
            .add(order.toJson())
            .catchError((e) {
          print(e);
        });
      } catch (e) {
        print(e);
      }
    }

    // return "";
  }

  getOrders() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("orders").get();


    return querySnapshot;
    return FirebaseFirestore.instance.collection('orders').snapshots().map(Order.fromSnapshot(snapshot));
  }

  // Future<dynamic> update(orderModel order, String id) async {
  //   try {
  //     order.createdAt = DateTime.now() as String;
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(uid)
  //         .collection('orders')
  //         .doc(id)
  //         .set(order.toMap(), SetOptions(merge: true));
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // Future<dynamic> delete(String id) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(uid)
  //         .collection('orders')
  //         .doc(id)
  //         .delete();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // orderProvider _ordersFromDocumentSnapshot(QuerySnapshot snapshot) {
  //   Map<String, order> orderList = {};
  //   for (QueryDocumentSnapshot order in snapshot.docs) {
  //     orderList[order.id] = order.fromMap(order.data());
  //   }
  //   return orderProvider(orders: orderList);
  // }

  // Stream<orderProvider> get orderList {
  //   if (uid == null) {
  //     return null;
  //   }
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uid)
  //       .collection('orders')
  //       .snapshots()
  //       .map(_ordersFromDocumentSnapshot);
  // }
}
