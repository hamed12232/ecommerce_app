import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/helper/pricing_calculator.dart';
import 'package:ecommerce_app/core/utils/popups/loaders.dart';
import 'package:ecommerce_app/core/utils/success_screen/success_screen.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/address_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/controller/cubit/cart_state.dart';
import 'package:ecommerce_app/features/shop/modules/order/presentation/controller/cubit/order_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/order/presentation/controller/cubit/order_state.dart';
import 'package:ecommerce_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, orderState) {
        if (orderState.saveStatus == SaveOrderStatus.success) {
          // Clear the cart after successful order
          context.read<CartCubit>().clearCart();
          AppHelperFunctions.navigateToScreen(
            context,
            SuccessScreenLottie(
              image: AppImages.successfulPaymentIcon,
              title: 'Payment Success!',
              subTitle: 'Your order has been placed successfully',
              onPressed: () {
                Navigator.pushNamed(context, NavigationMenu.routeName);
              },
            ),
          );
        } else if (orderState.saveStatus == SaveOrderStatus.error) {
          AppLoaders.errorSnackBar(
            title: orderState.error ?? 'Failed to place order',
            context: context,
          );
        }
      },
      builder: (context, orderState) {
        return BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) {
            final isLoading = orderState.saveStatus == SaveOrderStatus.loading;

            return Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: CustomButton(
                onPressed: isLoading
                    ? null
                    : () {
                        // Get the selected address
                        final addressState = context.read<AddressCubit>().state;
                        final selectedAddress = addressState.selectedAddress;

                        context.read<OrderCubit>().processOrder(
                          items: cartState.items,
                          totalAmount: PricingCalculator.calculateTotalPrice(
                            cartState.subtotal,
                            'US',
                          ),
                          address: selectedAddress?.toString(),
                        );
                      },
                text: isLoading
                    ? 'Processing...'
                    : 'Checkout \$${PricingCalculator.calculateTotalPrice(cartState.subtotal, 'US')}',
              ),
            );
          },
        );
      },
    );
  }
}
