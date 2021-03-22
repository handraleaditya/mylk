import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

import 'package:mylk/models/itemModel.dart';

class Order {
  List<Item> items;
  num total;
  String createdAt = DateTime.now().toString();
  String status;

  DocumentReference reference;

  Order(
    this.items,
    this.total,
    // this.createdAt,
    this.status,
    this.reference,
  );

  factory Order.fromJson(Map<dynamic, dynamic> json) => orderFromJson(json);

  factory Order.fromSnapshot(DocumentSnapshot snapshot) {
    Order neworder = Order.fromJson(snapshot.data());
    neworder.reference = snapshot.reference;
    return neworder;
  }

  // factory order.fromReference(DocumentReference reference){
  //   order neworder = order.fromJson
  // }

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
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      List<Item>.from(map['items']?.map((x) => Item.fromJson(x))),
      map['total'],
      map['createdAt'],
      map['status'],
      // (map['reference']),
    );
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
        other.reference == reference;
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
    // json['reference'] == null ? null : json['reference'],
  );

  // total: json['price'] == null ? null : json['price'],
  // imageUrl: json['imageUrl'] == null ? null : json['imageUrl'],
  // description: json['description'] == null ? null : json['description']);
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
    'createdAt': order.createdAt
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
