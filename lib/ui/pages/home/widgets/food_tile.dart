import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jc_recruit_app/bloc/cart/cart_bloc.dart';
import 'package:jc_recruit_app/bloc/food/food_bloc.dart';
import 'package:jc_recruit_app/models/food.dart';
import 'package:jc_recruit_app/repositories/food_repository.dart';
import 'package:jc_recruit_app/ui/common_widgets/network_image_shimmer.dart';
import 'package:jc_recruit_app/utils/enum.dart';
import 'package:jc_recruit_app/ui/common_widgets/snackbars.dart';
import 'package:transparent_image/transparent_image.dart';

class FoodItemTile extends StatefulWidget {
  const FoodItemTile({super.key, required this.foodItem});

  final FoodItem foodItem;

  @override
  State<FoodItemTile> createState() => _FoodItemTileState();
}

class _FoodItemTileState extends State<FoodItemTile> {
  void addToCart() {
    context
        .read<CartBloc>()
        .add(AddToCart(foodItem: widget.foodItem, change: CartItemChange.ADD));

    MyFlushBars.addToCartFlushBar(success: true).show(context);
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
          child: NetworkImageShimmer(
            image: widget.foodItem.imageUrl,
            fit: BoxFit.cover,
            imageWidth: 64,
            imageHeight: 64,
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
        ));
  }
}
