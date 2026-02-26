import 'package:ecommerce_app/core/style/spacing/horizental_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/popups/loaders.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_app/core/widgets/product_quantity_with_add_remove_button.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/controller/cubit/product_variation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class BottomCardWidget extends StatefulWidget {
  const BottomCardWidget({
    super.key,
    required this.dark,
    required this.theme,
    required this.product,
  });

  final bool dark;
  final ThemeData theme;
  final ProductEntity product;

  @override
  State<BottomCardWidget> createState() => _BottomCardWidgetState();
}

class _BottomCardWidgetState extends State<BottomCardWidget> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.defaultSpace,
        vertical: AppSizes.sm,
      ),
      color: widget.dark ? AppColors.dark : AppColors.lightBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Quantity controls
          ProductQuantityWithAddRemoveButton(
            quantity: _quantity,
            add: () => setState(() => _quantity++),
            remove: () =>
                setState(() => _quantity = (_quantity > 1) ? _quantity - 1 : 1),
          ),
          const HorizentalSpace(width: AppSizes.sm),

          // Add to Bag
          GestureDetector(
            onTap: () {
              final variationState = context
                  .read<ProductVariationCubit>()
                  .state;
              if(variationState.selectedVariation?.stock==0){
                AppLoaders.customToast(
                  message: 'This Product is out of stock',
                  context: context,
                );
                return;
              }
              context.read<CartCubit>().addToCart(
                widget.product,
                quantity: _quantity,
                variation: variationState.selectedVariation,
              );
              AppLoaders.customToast(
                message: 'Your Product has been added to Cart',
                context: context,
              );
            },
            child: RoundedContainer(
              height: 55,
              width: AppSizes.productItemHeight,
              radius: AppSizes.cardRadiusMd,
              backgroundColor: AppColors.darkBackground,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.shopping_bag, color: AppColors.white),
                  const HorizentalSpace(width: 8),
                  Text(
                    'Add to Bag',
                    style: widget.theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
