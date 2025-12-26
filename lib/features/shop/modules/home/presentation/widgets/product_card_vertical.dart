import 'package:ecommerce_app/core/style/shadows.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/enums.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/icons/circular_icons.dart';
import 'package:ecommerce_app/core/utils/images/rounded_images.dart';
import 'package:ecommerce_app/core/utils/text/brand_title_text_with_verified_icon.dart';
import 'package:ecommerce_app/core/utils/text/product_price_text.dart';
import 'package:ecommerce_app/core/utils/text/product_title_text.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/sale_percentage.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/product_details.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetails.routeName),
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
              width: 180,
              height: 180,
              padding: const EdgeInsets.all(AppSizes.sm),
              backgroundColor: dark ? AppColors.dark : AppColors.grey10,
              child: const Stack(
                children: [
                  Center(
                    child: RoundedImage(
                      imageUrl: AppImages.productImage1,
                      applyImageRadius: true,
                    ),
                  ),
                  Positioned(top: 12, child: SalePercentage()),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircularIcon(
                      icon: Iconsax.heart5,
                      size: AppSizes.iconMd,
                      color: AppColors.red,
                    ),
                  ),
                  VerticalSpace(height: AppSizes.spaceBtwItems / 2),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: AppSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTitleText(title: "product name", smallSize: true),
                  SizedBox(height: AppSizes.spaceBtwItems / 2),
                  BrandTitleWithVerifiedIcon(
                    title: "NIKE",
                    brandTextSize: TextSizes.small,
                    textColor: AppColors.darkGrey,
                  ),
                ],
              ),
            ),
            const VerticalSpace(height: AppSizes.spaceBtwSections),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: AppSizes.sm),
                        child: ProductPriceText(price: "120.00"),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
