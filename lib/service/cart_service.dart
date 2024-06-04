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

  Future<void> addToCart(String cartItemId, int change) async {
    await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .doc(cartItemId)
        .update({'quantity': FieldValue.increment(change)});
  }

  Future<void> removeFromCart(String cartItemId) async {
    await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .doc(cartItemId)
        .delete();
  }
}
