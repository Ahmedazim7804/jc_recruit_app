import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jc_recruit_app/bloc/cart/cart_bloc.dart';
import 'package:jc_recruit_app/bloc/food/food_bloc.dart';
import 'package:jc_recruit_app/models/food.dart';
import 'package:jc_recruit_app/repositories/food_repository.dart';
import 'package:jc_recruit_app/utils/enum.dart';

class FoodItemTile extends StatefulWidget {
  const FoodItemTile({super.key, required this.foodItem});

  final FoodItem foodItem;

  @override
  State<FoodItemTile> createState() => _FoodItemTileState();
}

class _FoodItemTileState extends State<FoodItemTile> {
  // void increment() {
  //   context.read<FoodBloc>().add(ChangeFoodItemQuantity(
  //       widget.foodItem, (widget.foodItem.quantity + 1)));
  // }

  // void decrement() {
  //   context.read<FoodBloc>().add(ChangeFoodItemQuantity(
  //       widget.foodItem, (widget.foodItem.quantity - 1)));
  // }

  void addToCart() {
    context
        .read<CartBloc>()
        .add(AddToCart(foodItem: widget.foodItem, change: CartItemChange.ADD));
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    FoodRepository(firestore).getFoods();

    return ListTile(
        visualDensity: const VisualDensity(vertical: 1.5),
        tileColor: Colors.white.withOpacity(0.05),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        leading: ClipOval(
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            'assets/dorito.jpg',
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
        trailing: IconButton(
          onPressed: addToCart,
          icon:
              Icon(Icons.shopping_cart, color: Colors.white.withOpacity(0.75)),
        )
        // : Wrap(
        //     crossAxisAlignment: WrapCrossAlignment.center,
        //     children: [
        //       IconButton(
        //           onPressed: decrement,
        //           icon: Icon(Icons.remove,
        //               color: Colors.white.withOpacity(0.75))),
        //       Text(
        //         widget.foodItem.quantity.toString(),
        //         textAlign: TextAlign.center,
        //         style: TextStyle(
        //           color: Colors.white.withOpacity(0.75),
        //           fontSize: 16,
        //         ),
        //       ),
        //       IconButton(
        //           onPressed: increment,
        //           icon:
        //               Icon(Icons.add, color: Colors.white.withOpacity(0.75))),
        //     ],
        //   ),
        );
  }
}

class FoodTileShimmer extends StatelessWidget {
  const FoodTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        visualDensity: const VisualDensity(vertical: 1.5),
        tileColor: Colors.white.withOpacity(0.05),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        leading: ClipOval(
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            'assets/dorito.jpg',
            width: 64,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),
        title: Container(
          width: 75,
          height: 16,
          color: Colors.grey[300],
        ),
        subtitle: Container(
          width: 25,
          height: 16,
          color: Colors.grey[300],
          child: const Text("  "),
        ),
        trailing: IconButton(
          onPressed: () {},
          icon:
              Icon(Icons.shopping_cart, color: Colors.white.withOpacity(0.75)),
        ));
  }
}
