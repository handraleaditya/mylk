import 'dart:convert';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String name;
  String description;
  num price;
  // int quantity;
  // String createdAt;
  String imageUrl;
  // bool outOfStock;
  DocumentReference reference;

  Item(this.name,
      {this.price, this.imageUrl, this.reference, this.description});

  factory Item.fromJson(Map<dynamic, dynamic> json) => ItemFromJson(json);

  factory Item.fromSnapshot(DocumentSnapshot snapshot) {
    Item newItem = Item.fromJson(snapshot.data());
    newItem.reference = snapshot.reference;
    return newItem;
  }

  Map<String, dynamic> toJson() => ItemToJson(this);
  @override
  String toString() => "Item<$name>";
}

Item ItemFromJson(Map<dynamic, dynamic> json) {
  return Item(json['name'] as String,
      price: json['price'] == null ? null : json['price'],
      imageUrl: json['imageUrl'] == null ? null : json['imageUrl'],
      description: json['description'] == null ? null : json['description']);
}

Map<String, dynamic> ItemToJson(Item item) {
  <String, dynamic>{
    'name': item.name,
    'description': item.description,
    'price': item.price,
    'imageUrl': item.imageUrl
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

// ItemModel.fromJson(Map<String, dynamic> data) {
//   this.name = data['name'];
//   this.price = data['price'];
//   this.description = data['description'];
//   this.quantity = data['quantity'];
//   this.createdAt = data['createdAt'];
//   this.imageUrl = data['imageUrl'];
// }
// ItemModel() {
//   this.name = "";
//   this.price = 0;
//   this.description = "";
//   this.quantity = 0;
//   this.createdAt = "";
//   this.imageUrl = "";
// }

// Map<String, dynamic> toMap() {
//   return {
//     'name': name,
//     'description': description,
//     'price': price,
//     'quantity': quantity,
//     'createdAt': createdAt,
//     'imageUrl': imageUrl,
//   };
// }

// String toJson() => json.encode(toMap());
