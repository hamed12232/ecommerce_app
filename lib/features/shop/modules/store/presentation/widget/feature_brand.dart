
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/enums.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/images/circular_image.dart';
import 'package:ecommerce_app/core/utils/text/brand_title_text_with_verified_icon.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';

class FeaturedBrand extends StatelessWidget {
  const FeaturedBrand({
    super.key,
    required this.isDark,
  });

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsetsGeometry.all(AppSizes.sm),
      showBorder: true,
      borderColor: isDark
          ? AppColors.borderLight
          : AppColors.darkGrey,
      backgroundColor: Colors.transparent,
      child: Row(
        children: [
          Flexible(
            child: CircularImage(
              image: AppImages.nikeLogo,
              isNetworkImage: false,
              backgroundColor: Colors.transparent,
              overlayColor: isDark
                  ? AppColors.white
                  : AppColors.black,
            ),
          ),
          const VerticalSpace(
            height: AppSizes.spaceBtwItems / 2,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BrandTitleWithVerifiedIcon(
                  title: "Nike",
                  brandTextSize: TextSizes.large,
                ),
                Text(
                  "20 Products",
                  style: Theme.of(context).textTheme.labelMedium
                      ?.copyWith(color: AppColors.darkGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
