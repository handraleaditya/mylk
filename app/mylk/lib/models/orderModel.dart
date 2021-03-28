import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:mylk/models/itemModel.dart';

class Order {
  List<Item> items;
  num total;
  String createdAt = DateTime.now().toString();
  String status;
  String uid;
  String name = "";
  String address = "";
  String address2 = "";
  String note = "";
  String phone = "";

  DocumentReference reference;

  Order(this.items, this.total, this.status, this.reference, this.uid,
      {this.name = "",
      this.address = "",
      this.address2 = "",
      this.note = "",
      this.phone = ""});

  factory Order.fromJson(Map<dynamic, dynamic> json) => orderFromJson(json);

  factory Order.fromSnapshot(DocumentSnapshot snapshot) {
    Order neworder = Order.fromJson(snapshot.data());
    neworder.reference = snapshot.reference;
    return neworder;
  }

  Map<String, dynamic> toJson() {
    return orderToJson(this);
  }

  @override
  String toString() {
    return 'Order(items: $items, total: $total, createdAt: $createdAt, status: $status, reference: $reference)';
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items?.map((x) => x.toJson())?.toList(),
      'total': total,
      'createdAt': createdAt,
      'status': status,
      'reference': reference,
      'uid': uid,
      'name': name,
      'address': address,
      'address2': address2,
      'note': note,
      'phone': phone
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(List<Item>.from(map['items']?.map((x) => Item.fromJson(x))),
        map['total'], map['createdAt'], map['status'], map['uid'],
        name: map['name'],
        address: map['address'],
        address2: map['address2'],
        note: map['note'],
        phone: map['phone']);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Order &&
        listEquals(other.items, items) &&
        other.total == total &&
        other.createdAt == createdAt &&
        other.status == status &&
        other.reference == reference &&
        other.uid == uid &&
        other.name == name &&
        other.address == address &&
        other.address2 == address2 &&
        other.note == note &&
        other.phone == phone &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return items.hashCode ^
        total.hashCode ^
        createdAt.hashCode ^
        status.hashCode ^
        reference.hashCode;
  }
}

Order orderFromJson(Map<dynamic, dynamic> json) {
  return Order(
    json['items'] == null ? null : json['items'],
    json['total'] == null ? null : json['total'],
    json['createdAt'] == null ? null : json['createdAt'],
    json['status'] == null ? null : json['status'],
    json['uid'] == null ? null : json['uid'],
    name: json['name'] == null ? null : json['name'],
    address: json['address'] == null ? null : json['address'],
    address2: json['address2'] == null ? null : json['address2'],
    note: json['note'] == null ? null : json['note'],
    phone: json['phone'] == null ? null : json['phone'],
  );
}

Map<String, dynamic> orderToJson(Order order) {
  List<Map<String, dynamic>> itemsMap = List<Map<String, dynamic>>();
  order.items.forEach((Item item) {
    itemsMap.add(item.toJson());
  });

  return <String, dynamic>{
    'total': order.total,
    'items': itemsMap,
    'status': order.status,
    'createdAt': order.createdAt,
    'uid': order.uid,
    'name': order.name,
    'address': order.address,
    'address2': order.address2,
    'note': order.note,
    'phone': order.phone
  };
}

List<Map<String, dynamic>> _orderList(List<Order> orders) {
  if (orders == null) {
    return null;
  }
  List<Map<String, dynamic>> orderMap = List<Map<String, dynamic>>();
  orders.forEach((order) {
    orderMap.add(order.toJson());
  });

  return orderMap;
}
