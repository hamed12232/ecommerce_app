import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/widget/cart_items.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark= AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      /// -- AppBar
      appBar: AppBar(
        title: Text(" Cart", style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: false,
        elevation: 0,
        backgroundColor: dark? AppColors.dark : AppColors.white,
      ),
        backgroundColor: dark? AppColors.dark : AppColors.white,
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace),

          /// -- Items in Cart
          child: CartItems(),
        ),
      ),

      /// -- Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () {},
            child: Text(
              'Checkout ',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ),
    );
  }
}
