import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/text/product_price_text.dart';
import 'package:ecommerce_app/core/widgets/product_quantity_with_add_remove_button.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/controller/cubit/cart_state.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/widget/cart_product_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.items.isEmpty) {
          return const Center(child: Text('Your cart is empty.'));
        }

        return ListView.separated(
          shrinkWrap: true,
          itemCount: state.items.length,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSizes.spaceBtwSections),
          itemBuilder: (context, index) {
            final item = state.items[index];

            return Column(
              children: [
                CartItem(item: item),
                if (showAddRemoveButtons)
                  const SizedBox(height: AppSizes.spaceBtwItems),

                if (showAddRemoveButtons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 70),
                          ProductQuantityWithAddRemoveButton(
                            quantity: item.quantity,
                            addButtonColor: AppColors.primary,
                            add: () => context.read<CartCubit>().updateQuantity(
                              item.productId,
                              item.variationId,
                              item.quantity + 1,
                            ),
                            remove: () =>
                                context.read<CartCubit>().updateQuantity(
                                  item.productId,
                                  item.variationId,
                                  item.quantity - 1,
                                ),
                          ),
                        ],
                      ),
                      ProductPriceText(
                        price: ((item.price ?? 0) * item.quantity)
                            .toStringAsFixed(2),
                      ),
                    ],
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
