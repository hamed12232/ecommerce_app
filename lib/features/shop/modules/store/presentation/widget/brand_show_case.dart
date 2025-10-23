import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/widget/feature_brand.dart';
import 'package:flutter/material.dart';

class BrandShowCase extends StatelessWidget {
  const BrandShowCase({super.key});

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
          FeaturedBrand(isDark: isDark),

          /// Brand Top 3 Product Images
          Row(
            children: [
              Expanded(
                child: RoundedContainer(
                  height: 100,
                  backgroundColor: AppHelperFunctions.isDarkMode(context)
                      ? AppColors.darkerGrey
                      : AppColors.lightGrey,
                  margin: const EdgeInsets.only(right: AppSizes.sm),
                  padding: const EdgeInsets.all(AppSizes.md),
                  child: const Image(
                    fit: BoxFit.contain,
                    image: AssetImage(AppImages.productImage1),
                  ),
                ),
              ),
              Expanded(
                child: RoundedContainer(
                  height: 100,
                  backgroundColor: AppHelperFunctions.isDarkMode(context)
                      ? AppColors.darkerGrey
                      : AppColors.lightGrey,
                  margin: const EdgeInsets.only(right: AppSizes.sm),
                  padding: const EdgeInsets.all(AppSizes.md),
                  child: const Image(
                    fit: BoxFit.contain,
                    image: AssetImage(AppImages.productImage5),
                  ),
                ),
              ),
              Expanded(
                child: RoundedContainer(
                  height: 100,
                  backgroundColor: AppHelperFunctions.isDarkMode(context)
                      ? AppColors.darkerGrey
                      : AppColors.lightGrey,
                  margin: const EdgeInsets.only(right: AppSizes.sm),
                  padding: const EdgeInsets.all(AppSizes.md),
                  child: const Image(
                    fit: BoxFit.contain,
                    image: AssetImage(AppImages.productImage22),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
