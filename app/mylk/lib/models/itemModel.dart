import 'dart:convert';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String name;
  String description;
  num price;
  int quantity;
  // String createdAt;
  String imageUrl;
  bool outOfStock = false;

  // bool outOfStock;
  DocumentReference reference;

  Item(this.name,
      {this.price,
      this.imageUrl,
      this.reference,
      this.description,
      this.quantity,
      this.outOfStock});

  factory Item.fromJson(Map<dynamic, dynamic> json) => ItemFromJson(json);

  factory Item.fromSnapshot(DocumentSnapshot snapshot) {
    Item newItem = Item.fromJson(snapshot.data());
    newItem.reference = snapshot.reference;
    return newItem;
  }

  // factory Item.fromReference(DocumentReference reference){
  //   Item newItem = Item.fromJson
  // }

  Map<String, dynamic> toJson() {
    return ItemToJson(this);
  }

  @override
  String toString() => "Item<$name>";
}

Item ItemFromJson(Map<dynamic, dynamic> json) {
  return Item(json['name'] as String,
      price: json['price'] == null ? null : json['price'],
      imageUrl: json['imageUrl'] == null ? null : json['imageUrl'],
      quantity: json['quantity'] == null ? null : json['quantity'],
      outOfStock: json['outOfStock'] == null ? false : json['outOfStock'],
      description: json['description'] == null ? null : json['description']);
}

Map<String, dynamic> ItemToJson(Item item) {
  return <String, dynamic>{
    'name': item.name,
    'description': item.description,
    'price': item.price,
    'imageUrl': item.imageUrl,
    'quantity': item.quantity,
    'outOfStock': item.outOfStock,
  };
}

List<Map<String, dynamic>> _ItemList(List<Item> items) {
  if (items == null) {
    return null;
  }
  List<Map<String, dynamic>> itemMap = List<Map<String, dynamic>>();
  items.forEach((item) {
    itemMap.add(item.toJson());
  });
  return itemMap;
}
