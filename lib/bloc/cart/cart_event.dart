part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class GetCartFromFirebase extends CartEvent {}

final class AddToCart extends CartEvent {
  final FoodItem foodItem;
  final CartItemChange change;

  const AddToCart({required this.foodItem, required this.change});

  @override
  List<Object> get props => [foodItem, change];
}
