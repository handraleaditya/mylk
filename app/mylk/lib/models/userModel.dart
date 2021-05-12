import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name = "";
  String address1, address2 = "";
  String mobile = "";
  String mobile2 = "";

  DocumentReference reference;
  String uid;
  DateTime createdAt = DateTime.now().toString() as DateTime;
  DateTime updatedAt = DateTime.now().toString() as DateTime;

  User({
    this.createdAt,
    this.updatedAt,
    this.address1 = "",
    this.address2 = "",
    this.mobile = "",
    this.name = "",
    this.mobile2 = "",
  });

  factory User.fromJson(Map<dynamic, dynamic> json) => UserFromJson(json);
  Map<String, dynamic> toJson() => UserToJson(this);

  @override
  String toString() => "Item<$name>";
}

User UserFromJson(Map<dynamic, dynamic> json) {
  return User(
    name: json['name'] == null ? null : json['name'],
    mobile: json['mobile'] == null ? null : json['mobile'],
    mobile2: json['mobile2'] == null ? null : json['mobile2'],
    address1: json['address1'] == null ? null : json['address1'],
    address2: json['address2'] == null ? null : json['address2'],
    updatedAt: json['updatedAt'] == null ? null : json['updatedAt'],
    createdAt: json['createdAt'] == null ? null : json['createdAt'],
  );
}

Map<String, dynamic> UserToJson(User user) {
  <String, dynamic>{
    'name': user.name,
    'address1': user.address1,
    'address2': user.address2,
    'uid': user.uid,
    'mobile': user.mobile,
    'mobile2': user.mobile2,
    'createdAt': user.createdAt,
    'updatedAt': user.updatedAt
  };
}
