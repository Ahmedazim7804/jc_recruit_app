import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jc_recruit_app/bloc/cart/cart_bloc.dart';
import 'package:jc_recruit_app/bloc/food/food_bloc.dart';
import 'package:jc_recruit_app/models/food.dart';
import 'package:jc_recruit_app/widgets/cart_item_tile.dart';

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
          List<FoodItem> foodList = context.read<FoodBloc>().backupFood;
          print(state);
          if (state is CartLoaded && foodList.isNotEmpty) {
            Map<String, FoodItem> foodMap = {
              for (var food in foodList) food.id: food
            };

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
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
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
                          Text("₹220",
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
                          Text("₹220",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.87),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
