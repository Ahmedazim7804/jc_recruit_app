import 'package:equatable/equatable.dart';
import 'package:jc_recruit_app/models/food.dart';

class CartItem extends Equatable {
  const CartItem({required this.foodId, required this.quantity});
  final String foodId;
  final int quantity;

  @override
  List<Object?> get props => [foodId, quantity];

  factory CartItem.fromJson(Map<String, dynamic> json, String foodId) {
    return CartItem(
      foodId: foodId,
      quantity: json['quantity'],
    );
  }
}
