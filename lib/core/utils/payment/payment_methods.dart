import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/features/shop/modules/checkout/model/payment_method_model.dart';
import 'package:ecommerce_app/features/shop/modules/checkout/presentation/widget/payment_tile.dart';
import 'package:flutter/material.dart';

class PaymentMethods {
static  Future<dynamic> selectPaymentMethod(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(title: 'Select Payment Method', showActionButton: false),
              const SizedBox(height: AppSizes.spaceBtwSections),
              PaymentTile(paymentMethod: PaymentMethodModel(name: 'Paypal', image: AppImages.paypal)),
              const SizedBox(height: AppSizes.spaceBtwItems/2),
              PaymentTile(paymentMethod: PaymentMethodModel(name: 'Google Pay', image: AppImages.googlePay)),
              const SizedBox(height: AppSizes.spaceBtwItems/2),
              PaymentTile(paymentMethod: PaymentMethodModel(name: 'Apple Pay', image: AppImages.applePay)),
              const SizedBox(height: AppSizes.spaceBtwItems/2),
              PaymentTile(paymentMethod: PaymentMethodModel(name: 'VISA', image: AppImages.visa)),
              const SizedBox(height: AppSizes.spaceBtwItems/2),
              PaymentTile(paymentMethod: PaymentMethodModel(name: 'Master Card', image: AppImages.masterCard)),
              const SizedBox(height: AppSizes.spaceBtwItems/2),
              PaymentTile(paymentMethod: PaymentMethodModel(name: 'Paytm', image: AppImages.paytm)),
              const SizedBox(height: AppSizes.spaceBtwItems/2),
              PaymentTile(paymentMethod: PaymentMethodModel(name: 'Paystack', image: AppImages.paystack)),
              const SizedBox(height: AppSizes.spaceBtwItems/2),
              PaymentTile(paymentMethod: PaymentMethodModel(name: 'Credit Card', image: AppImages.creditCard)),
              const SizedBox(height: AppSizes.spaceBtwItems/2),
              const SizedBox(height: AppSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}