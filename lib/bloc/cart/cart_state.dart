part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartLoading extends CartState {}

final class CartEmpty extends CartState {}

final class CartLoaded extends CartState {
  final List<CartItem> cartItems;

  const CartLoaded(this.cartItems);

  @override
  List<Object> get props => [cartItems];
}
