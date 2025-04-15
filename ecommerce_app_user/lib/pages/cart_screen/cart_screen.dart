import 'package:ecommerce_app_user/constants/constants.dart';
import 'package:ecommerce_app_user/constants/routes.dart';
import 'package:ecommerce_app_user/pages/cart_item_checkout/cart_item_checkout.dart';
import 'package:ecommerce_app_user/pages/cart_screen/widgets/cart_single_item.dart';
import 'package:ecommerce_app_user/pages/favourite_screen/favourite_screen.dart';
import 'package:ecommerce_app_user/provider/app_provider.dart';
import 'package:ecommerce_app_user/widgets/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Tổng tiền",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${appProvider.totalPrice().toString()}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                title: "Thanh toán",
                onPressed: () {
                  appProvider.clearBuyProduct();
                  appProvider.addBuyProductCartList();
                  appProvider.clearCart();
                  print(appProvider.getCartProductList);
                  if (appProvider.getBuyProductList.isEmpty) {
                    showMessage("Giỏ hàng rỗng");
                  } else {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: CartItemCheckout(),
                      withNavBar: false,
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Giỏ hàng",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: appProvider.getCartProductList.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (ctx, item) {
          return CartSingleItem(
            singleProduct: appProvider.getCartProductList[item],
          );
        },
      ),
    );
  }
}
