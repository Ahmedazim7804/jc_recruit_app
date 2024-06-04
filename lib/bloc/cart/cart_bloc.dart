import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jc_recruit_app/models/cart_item.dart';
import 'package:jc_recruit_app/models/food.dart';
import 'package:jc_recruit_app/repositories/cart_repository.dart';
import 'package:jc_recruit_app/utils/enum.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<GetCartFromFirebase>(_handleGetCartFromFirebase);
    on<AddToCart>(_handleAddToCart);
  }

  final CartRepository cartRepository = CartRepository(
      FirebaseFirestore.instance,
      userId: FirebaseAuth.instance.currentUser!.uid);

  void _handleGetCartFromFirebase(
      GetCartFromFirebase event, Emitter<CartState> emit) async {
    emit(CartLoading());

    await emit.forEach(
      cartRepository.getCart(),
      onData: (data) {
        if (data.isEmpty) {
          return CartEmpty();
        }

        return CartLoaded(data);
      },
    );
  }

  void _handleAddToCart(AddToCart event, Emitter<CartState> emit) async {
    emit(CartLoading());

    await cartRepository.addToCart(event.foodItem.id, event.change.value);
  }
}
