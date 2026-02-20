import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/images/rounded_images.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/entities/brand_entity.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/widget/feature_brand.dart';
import 'package:flutter/material.dart';

class BrandShowCase extends StatelessWidget {
  const BrandShowCase({super.key, required this.brand, required this.images});

  final BrandEntity brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    return RoundedContainer(
      showBorder: true,
      borderColor: AppColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(AppSizes.md),
      margin: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
      child: Column(
        children: [
          /// Brand with Products Count
          FeaturedBrand(isDark: isDark, brand: brand),

          /// Brand Top 3 Product Images
          Row(
            children: images
                .map(
                  (image) => Expanded(
                    child: RoundedContainer(
                      height: 100,
                      backgroundColor: isDark
                          ? AppColors.darkerGrey
                          : AppColors.lightGrey,
                      margin: const EdgeInsets.only(right: AppSizes.sm),
                      padding: const EdgeInsets.all(AppSizes.md),
                      child: RoundedImage(
                        imageUrl: image,
                        isNetworkImage: true,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
