import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/helper/pricing_calculator.dart';
import 'package:ecommerce_app/core/utils/success_screen/success_screen.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/controller/cubit/cart_state.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/widget/cart_items.dart';
import 'package:ecommerce_app/features/shop/modules/checkout/presentation/widget/billing_address_section.dart';
import 'package:ecommerce_app/features/shop/modules/checkout/presentation/widget/billing_amount_section.dart';
import 'package:ecommerce_app/features/shop/modules/checkout/presentation/widget/billing_payment_section.dart';
import 'package:ecommerce_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  static const String routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Review",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: dark ? AppColors.dark : AppColors.white,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CartItems(showAddRemoveButtons: false),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                  RoundedContainer(
                    borderColor: dark ? AppColors.darkerGrey : AppColors.grey,
                    showBorder: true,
                    padding: const EdgeInsets.all(AppSizes.md),
                    backgroundColor: dark ? AppColors.black : AppColors.white,
                    child: Column(
                      children: [
                        BillingAmountSection(subTotal: state.subtotal),
                        const SizedBox(height: AppSizes.spaceBtwItems),
                        const Divider(),
                        const SizedBox(height: AppSizes.spaceBtwItems),
                        const BillingPaymentSection(),
                        const SizedBox(height: AppSizes.spaceBtwSections),
                        const BillingAddressSection(
                          name: "Hamza",
                          address: "123 Main Street, New York, NY 10001",
                          phoneNumber: "123-456-7890",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),
                ],
              ),
            ),
          );
        },
      ),

      /// -- Checkout Button
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: CustomButton(
              onPressed: () => {
                AppHelperFunctions.navigateToScreen(
                  context,
                  SuccessScreenLottie(
                    image: AppImages.successfulPaymentIcon,
                    title: 'Success',
                    subTitle: 'Your order has been placed successfully',
                    onPressed: () {
                      context.read<CartCubit>().clearCart();
                      Navigator.pushNamed(context, NavigationMenu.routeName);
                    },
                  ),
                ),
              },
              text:
                  'Checkout \$${PricingCalculator.calculateTotalPrice(state.subtotal, 'US')}',
            ),
          );
        },
      ),
    );
  }
}
