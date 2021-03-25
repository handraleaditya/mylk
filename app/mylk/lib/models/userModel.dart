import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name = "";
  String address1, address2 = "";
  String mobile = "";
  DocumentReference reference;
  String uid;
  DateTime createdAt;
  DateTime updatedAt = DateTime.now().toString() as DateTime;

  User({
    this.updatedAt,
    this.address1 = "",
    this.address2 = "",
    this.mobile = "",
    this.name = "",
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
    address1: json['address1'] == null ? null : json['address1'],
    address2: json['address2'] == null ? null : json['address2'],
    updatedAt: json['updatedAt'] == null ? null : json['updatedAt'],
  );
}

Map<String, dynamic> UserToJson(User user) {
  <String, dynamic>{
    'name': user.name,
    'address1': user.address1,
    'address2': user.address2,
    'uid': user.uid,
    'mobile': user.mobile,
    'createdAt': user.createdAt,
    'updatedAt': user.updatedAt
  };
}
