import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Hoppr/consts/routes/app_routes_name.dart';
import 'package:Hoppr/main.dart';
import 'package:Hoppr/presentation/cart/cart_screen.dart';
import 'package:Hoppr/providers/cart_provider.dart';

class CartOrderCount extends ConsumerWidget {
  const CartOrderCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CartProvider cp = ref.watch(cartService);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          Icons.shopping_bag_outlined,
          size: 28,
        ),
        cp.carts.isNotEmpty
        ?Positioned(
            right: -3,
            top: -5,
            child: GestureDetector(
              onTap: () {
                navigatorKey.currentState!.push(
                    MaterialPageRoute(
                      builder: (context) =>  CartScreen(),
                    ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    cp.carts.length.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            )): SizedBox(),
      ],
    );
  }
}
