import 'package:ecommerce_app/core/style/shadows.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/enums.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/helper/pricing_calculator.dart';
import 'package:ecommerce_app/core/utils/icons/favourite_icon.dart';
import 'package:ecommerce_app/core/utils/images/rounded_images.dart';
import 'package:ecommerce_app/core/utils/text/brand_title_text_with_verified_icon.dart';
import 'package:ecommerce_app/core/utils/text/product_price_text.dart';
import 'package:ecommerce_app/core/utils/text/product_title_text.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/controller/cubit/cart_state.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/sale_percentage.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key, required this.product});

  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    final salePercentage = PricingCalculator.calculateSalePercentage(
      product.price,
      product.salePrice,
    );
    final dark = AppHelperFunctions.isDarkMode(context);

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        ProductDetails.routeName,
        arguments: product,
      ),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(AppSizes.productImageRadius),
          color: dark ? AppColors.darkerGrey : AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(AppSizes.sm),
              backgroundColor: dark ? AppColors.dark : AppColors.grey10,
              child: Stack(
                children: [
                  Center(
                    child: RoundedImage(
                      imageUrl: product.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ),
                  if (salePercentage != null)
                    Positioned(
                      top: 12,
                      child: SalePercentage(percentage: salePercentage),
                    ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: FavouriteIcon(productId: product.id),
                  ),
                  const VerticalSpace(height: AppSizes.spaceBtwItems / 2),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: AppSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTitleText(title: product.title, smallSize: true),
                  const SizedBox(height: AppSizes.spaceBtwItems / 2),
                  BrandTitleWithVerifiedIcon(
                    title: product.brand?.name ?? '',
                    brandTextSize: TextSizes.small,
                    textColor: AppColors.darkGrey,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (product.productType ==
                              ProductType.single.toString() &&
                          product.salePrice != null &&
                          product.salePrice! > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: AppSizes.sm),
                          child: Text(
                            product.price.toString(),
                            style: Theme.of(context).textTheme.labelMedium!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: AppSizes.sm),
                        child: ProductPriceText(
                          price: PricingCalculator.getProductPrice(product),
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    final itemOpt = state.items
                        .where((e) => e.productId == product.id)
                        .toList();
                    final int qtyInCart = itemOpt.fold(
                      0,
                      (sum, e) => sum + e.quantity,
                    );

                    if (qtyInCart > 0) {
                      return GestureDetector(
                        onTap: () {
                          context.read<CartCubit>().addToCart(product);
                        },
                        child: AnimatedContainer(
                          curve: Curves.easeInOutCubicEmphasized,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppSizes.cardRadiusMd),
                              bottomRight: Radius.circular(
                                AppSizes.productImageRadius,
                              ),
                            ),
                          ),
                          duration: const Duration(milliseconds: 300),
                          child: SizedBox(
                            width: AppSizes.iconLg * 1.2,
                            height: AppSizes.iconLg * 1.2,
                            child: Center(
                              child: Text(
                                qtyInCart.toString(),
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .apply(color: AppColors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    return GestureDetector(
                      onTap: () {
                        context.read<CartCubit>().addToCart(product);
                      },
                      child: AnimatedContainer(
                        curve: Curves.easeInOutCubicEmphasized,
                        decoration: const BoxDecoration(
                          color: AppColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppSizes.cardRadiusMd),
                            bottomRight: Radius.circular(
                              AppSizes.productImageRadius,
                            ),
                          ),
                        ),
                        duration: const Duration(milliseconds: 300),
                        child: const SizedBox(
                          width: AppSizes.iconLg * 1.2,
                          height: AppSizes.iconLg * 1.2,
                          child: Center(
                            child: Icon(Iconsax.add, color: AppColors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
