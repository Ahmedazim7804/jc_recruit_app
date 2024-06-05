import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  CategoryService(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<QuerySnapshot> getCategories() {
    return _firestore.collection('categories').snapshots();
  }
}
