import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirebaseService extends GetxController {
  final CollectionReference data =
      FirebaseFirestore.instance.collection('userdata');

  Future<void> addData(String name) {
    return data.add({
      'name': name,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getData() {
    return data.snapshots();
  }

  Future<void> deleteData(String docId) {
    return data.doc(docId).delete();
  }

  Future<void> updateData(String docId, String newName) {
    return data.doc(docId).update({
      'name': newName,
      'timestamp': Timestamp.now(),
    });
  }
}
