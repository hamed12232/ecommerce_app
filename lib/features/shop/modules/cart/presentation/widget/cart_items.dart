import 'package:ecommerce_app/core/utils/constant/categories.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/text/product_price_text.dart';
import 'package:ecommerce_app/core/widgets/product_quantity_with_add_remove_button.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/widget/cart_product_style.dart';
import 'package:flutter/material.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 5,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppSizes.spaceBtwSections),
      itemBuilder: (context, index) {
        final item = cartItems[index];

        return Column(
          children: [
            /// -- Cart Items
            CartItem(item: item),
            if (showAddRemoveButtons)
              const SizedBox(height: AppSizes.spaceBtwItems),

            /// -- Add Remove Buttons and Price Total
            if (showAddRemoveButtons)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// -- Add Remove Buttons
                  Row(
                    children: [
                      // Use to add space to the left of Buttons as image space.
                      const SizedBox(width: 70),

                      /// Add Remove Buttons
                      ProductQuantityWithAddRemoveButton(theme: theme,addButtonColor: AppColors.primary,),
                    ],
                  ),

                  /// -- Product total price
                  ProductPriceText(price: item.price.toString()),
                ],
              ),
          ],
        );
      },
    );
  }
}
