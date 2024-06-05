import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jc_recruit_app/router/router.dart';
import 'package:jc_recruit_app/ui/pages/home/widgets/category_widget.dart';
import 'package:jc_recruit_app/ui/pages/home/widgets/food_search.dart';
import 'package:jc_recruit_app/ui/pages/home/widgets/food_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push(AppRoutes.CART_PAGE.value);
          },
          backgroundColor: const Color(0xff2846A8),
          shape: const CircleBorder(),
          child: Icon(Icons.shopping_cart_checkout,
              color: Colors.white.withOpacity(0.87)),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/logo.png', height: 80, width: 120),
                  IconButton.filled(
                      style: IconButton.styleFrom(
                          backgroundColor: const Color(0xff2846A8)),
                      onPressed: () {},
                      icon: const Icon(Icons.history))
                ],
              ),
              Text(
                "WHAT WOULD YOU LIKE",
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 1.5,
                  color: Colors.white.withOpacity(0.87),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "TO EAT",
                textAlign: TextAlign.start,
                style: TextStyle(
                  height: 0,
                  letterSpacing: 1.5,
                  fontSize: 28,
                  color: Colors.white.withOpacity(0.87),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: FoodSearchWidget()),
              const CategoryWidget(),
              const SizedBox(
                height: 8,
              ),
              const FoodListWidget()
            ],
          ),
        ),
      ),
    );
  }
}
