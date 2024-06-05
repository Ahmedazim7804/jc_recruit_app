import 'package:flutter/material.dart';
import 'package:jc_recruit_app/ui/pages/cart/widgets/cart_tile_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class CartPageShimmer extends StatelessWidget {
  const CartPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[700]!,
        highlightColor: Colors.grey[500]!,
        enabled: true,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 3,
                separatorBuilder: (context, index) => const Divider(
                  indent: 16,
                  endIndent: 16,
                  color: Colors.white,
                ),
                itemBuilder: (context, index) {
                  return const CartTileShimmer();
                },
              ),
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
        ));
  }
}
