import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jc_recruit_app/bloc/cart/cart_bloc.dart';
import 'package:jc_recruit_app/models/food.dart';
import 'package:jc_recruit_app/repositories/food_repository.dart';
import 'package:jc_recruit_app/utils/enum.dart';
import 'package:transparent_image/transparent_image.dart';

class CartItemTile extends StatefulWidget {
  const CartItemTile(
      {super.key, required this.foodItem, required this.quantity});

  final FoodItem foodItem;
  final int quantity;

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  void increment() {
    context.read<CartBloc>().add(
          AddToCart(foodItem: widget.foodItem, change: CartItemChange.ADD),
        );
  }

  void decrement() {
    context.read<CartBloc>().add(
          AddToCart(foodItem: widget.foodItem, change: CartItemChange.REMOVE),
        );
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    FoodRepository(firestore).getFoods();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: 1.5),
        tileColor: Colors.white.withOpacity(0.05),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        leading: ClipOval(
          clipBehavior: Clip.antiAlias,
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: widget.foodItem.imageUrl,
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          widget.foodItem.name,
          style: TextStyle(
            color: Colors.white.withOpacity(0.87),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "₹${widget.foodItem.price}",
          style: TextStyle(
            color: Colors.white.withOpacity(0.75),
            fontSize: 14,
          ),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color(0xff2846A8),
          ),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              IconButton(
                  onPressed: decrement,
                  icon: Icon(Icons.remove,
                      color: Colors.white.withOpacity(0.75))),
              Text(
                widget.quantity.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 16,
                ),
              ),
              IconButton(
                  onPressed: increment,
                  icon: Icon(Icons.add, color: Colors.white.withOpacity(0.75))),
            ],
          ),
        ),
      ),
    );
  }
}
