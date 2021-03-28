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
    return newCollection.where('status', isEqualTo: 'placed').snapshots();

    // return newCollection;
    // return collection.where('category', isEqualTo: '').snapshots();
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
