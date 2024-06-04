import 'package:cloud_firestore/cloud_firestore.dart';

class FoodService {
  FoodService(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<QuerySnapshot> getFoods() {
    return _firestore.collection('foods').snapshots();
  }
}
