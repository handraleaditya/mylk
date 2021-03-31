import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mylk/models/itemModel.dart';

class DataRepository {
  // 1
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('items');
  // 2
  Stream<QuerySnapshot> getStream(String category) {
    if (category == 'all') {
      return collection.snapshots();
    } else
      return collection.where('category', isEqualTo: category).snapshots();
  }

  Stream<QuerySnapshot> getNewOrderStream() {
    CollectionReference newCollection =
        FirebaseFirestore.instance.collection('orders');
    return newCollection
        .where('status', isEqualTo: 'placed')
        .orderBy('createdAt', descending: true)
        .snapshots();

    // return newCollection;
    // return collection.where('category', isEqualTo: '').snapshots();
  }

  Stream<QuerySnapshot> getCompletedOrderStream() {
    CollectionReference newCollection =
        FirebaseFirestore.instance.collection('orders');
    return newCollection
        .where('status', isEqualTo: 'completed')
        .orderBy('createdAt', descending: true)
        .snapshots();

    // return newCollection;
    // return collection.where('category', isEqualTo: '').snapshots();
  }

  Stream<QuerySnapshot> getCancelledOrderStream() {
    CollectionReference newCollection =
        FirebaseFirestore.instance.collection('orders');
    return newCollection
        .where('status', isEqualTo: 'canceled')
        .orderBy('createdAt', descending: true)
        .snapshots();

    // return newCollection;
    // return collection.where('category', isEqualTo: '').snapshots();
  }

  Stream<QuerySnapshot> getAcceptedOrderstream() {
    CollectionReference newCollection =
        FirebaseFirestore.instance.collection('orders');
    return newCollection
        .where('status', isEqualTo: 'accepted')
        .orderBy('createdAt', descending: true)
        .snapshots();

    // return newCollection;
    // return collection.where('category', isEqualTo: '').snapshots();
  }

  Stream<QuerySnapshot> getAllUsersStream() {
    CollectionReference newCollection =
        FirebaseFirestore.instance.collection('users');
    return newCollection.snapshots();
  }

  Stream<QuerySnapshot> getReportsStream() {
    CollectionReference newCollection =
        FirebaseFirestore.instance.collection('reports');
    return newCollection.snapshots();
  }

  // 3
  Future<DocumentReference> addItem(Item item) {
    return collection.add(item.toJson());
  }

  // 4
  updateItem(Item item) async {
    await collection.doc(item.reference.id).update(item.toJson());
  }
}
