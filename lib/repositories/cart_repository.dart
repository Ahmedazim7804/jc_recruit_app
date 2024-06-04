import 'package:jc_recruit_app/models/cart_item.dart';
import 'package:jc_recruit_app/service/cart_service.dart';

class CartRepository {
  late final CartService _cartService;

  CartRepository(firestore, {required userId}) {
    _cartService = CartService(firestore, userId: userId);
  }

  Stream<List<CartItem>> getCart() {
    return _cartService.getCart().map((event) =>
        event.docs.where((element) => element.data() != null).map((doc) {
          return CartItem.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        }).toList());
  }

  Future<void> addToCart(String cartItemId, int change) async {
    await _cartService.addToCart(cartItemId, change);
  }
}
