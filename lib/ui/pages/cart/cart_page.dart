import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jc_recruit_app/bloc/cart/cart_bloc.dart';
import 'package:jc_recruit_app/bloc/food/food_bloc.dart';
import 'package:jc_recruit_app/models/food.dart';
import 'package:jc_recruit_app/ui/pages/cart/cart_page_shimmer.dart';
import 'package:jc_recruit_app/ui/pages/cart/widgets/cart_item_tile.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white.withOpacity(0.87),
        ),
        title: Text(
          "Cart",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.87)),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        buildWhen: (_, __) => context.read<FoodBloc>().backupFood.isNotEmpty,
        builder: (context, state) {
          if (state is CartEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/empty_cart.png',
                    width: 80,
                    height: 80,
                    color: Colors.white.withOpacity(0.75),
                  ),
                  Text(
                    "Add something\nto cart",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.75),
                    ),
                  ),
                ],
              ),
            );
          }

          List<FoodItem> foodList = context.read<FoodBloc>().backupFood;

          if (state is CartLoaded && foodList.isNotEmpty) {
            Map<String, FoodItem> foodMap = {
              for (var food in foodList) food.id: food
            };

            int subtotal = state.cartItems.fold(
                0,
                (previousValue, element) =>
                    previousValue +
                    (foodMap[element.foodId]!.price * element.quantity));

            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.cartItems.length,
                    separatorBuilder: (context, index) => const Divider(
                      indent: 16,
                      endIndent: 16,
                      color: Colors.white,
                    ),
                    itemBuilder: (context, index) {
                      return CartItemTile(
                        foodItem:
                            foodMap[state.cartItems.elementAt(index).foodId]!,
                        quantity: state.cartItems.elementAt(index).quantity,
                      );
                    },
                  ),
                ),
                Container(
                  height: 16,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.87),
                              fontSize: 16,
                            ),
                          ),
                          Text("₹${subtotal.toString()}",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.87),
                                fontSize: 16,
                              )),
                        ],
                      ),
                      Divider(
                        color: Colors.white.withOpacity(0.75),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.87),
                              fontSize: 16,
                            ),
                          ),
                          Text("₹0",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.87),
                                fontSize: 16,
                              )),
                        ],
                      ),
                      Divider(
                        color: Colors.white.withOpacity(0.75),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.87),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("₹${subtotal.toString()}",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.87),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2846A8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 32,
                            ),
                          ),
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.87),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const CartPageShimmer();
        },
      ),
    );
  }
}
