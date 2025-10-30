import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/helper/pricing_calcalutions.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/widget/cart_items.dart';
import 'package:ecommerce_app/features/shop/modules/checkout/presentation/widget/billing_address_section.dart';
import 'package:ecommerce_app/features/shop/modules/checkout/presentation/widget/billing_amount_section.dart';
import 'package:ecommerce_app/features/shop/modules/checkout/presentation/widget/billing_payment_section.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

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
        backgroundColor: dark ? AppColors.dark : AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// -- Items in Cart
              const CartItems(showAddRemoveButtons: false),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// -- Coupon TextField
              // const TCouponCode(),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// -- Billing Section
              RoundedContainer(
                borderColor: dark ? AppColors.darkerGrey : AppColors.grey,
                showBorder: true,
                padding: const EdgeInsets.all(AppSizes.md),
                backgroundColor: dark ? AppColors.black : AppColors.white,
                child: const Column(
                  children: [
                    /// Pricing
                    BillingAmountSection(subTotal: 5),
                    SizedBox(height: AppSizes.spaceBtwItems),

                    /// Divider
                    Divider(),
                    SizedBox(height: AppSizes.spaceBtwItems),

                    /// Payment Methods
                    BillingPaymentSection(),
                    SizedBox(height: AppSizes.spaceBtwSections),

                    /// Address
                    BillingAddressSection(
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
      ),

      /// -- Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: CustomButton(
          text: 'Checkout \$${PricingCalculator.calculateTotalPrice(20, 'US')}',
        ),
      ),
    );
  }
}
