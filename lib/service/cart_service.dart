import 'package:cloud_firestore/cloud_firestore.dart';

class CartService {
  CartService(this._firestore, {required this.userId});

  final FirebaseFirestore _firestore;
  final String userId;

  Stream<QuerySnapshot> getCart() {
    return _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .snapshots();
  }

  Future<void> addToCart(String cartItemId, int change) {
    return _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .doc(cartItemId)
        .set({'quantity': FieldValue.increment(change)});
  }
}
