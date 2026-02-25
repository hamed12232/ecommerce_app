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
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/sale_percentage.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/product_details.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    // Calculate sale percentage
    String? salePercentage = PricingCalculator.calculateSalePercentage(
      product.price,
      product.salePrice,
    );

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetails.routeName,
          arguments: product,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.productImageRadius),
          color: dark ? AppColors.darkerGrey : AppColors.softGrey,
        ),
        child: Row(
          children: [
            /// 1. Thumbnail Image
            RoundedContainer(
              padding: const EdgeInsets.all(AppSizes.sm),
              backgroundColor: dark ? AppColors.dark : AppColors.grey10,
              child: Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
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
                ],
              ),
            ),

            /// 2. Details Section (Expanded to fill space)
            SizedBox(
              width: 160,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppSizes.sm,
                  left: AppSizes.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Top Details (Title, Brand)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProductTitleText(title: product.title, smallSize: true),
                        const SizedBox(height: AppSizes.spaceBtwItems / 2),
                        if (product.brand != null)
                          BrandTitleWithVerifiedIcon(
                            title: product.brand!.name,
                            brandTextSize: TextSizes.small,
                            textColor: AppColors.darkGrey,
                          ),
                      ],
                    ),

                    const Spacer(),

                    /// Bottom Row (Price, Add Button)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: AppSizes.sm),
                            child: ProductPriceText(
                              price: PricingCalculator.getProductPrice(product),
                            ),
                          ),
                        ),

                        /// Add to cart
                        GestureDetector(
                          onTap: () {
                            // TODO: Add to cart logic
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
                                child: Icon(
                                  Iconsax.add,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
