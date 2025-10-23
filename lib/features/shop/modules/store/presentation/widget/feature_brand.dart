import 'package:ecommerce_app/core/style/spacing/horizental_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/enums.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/images/circular_image.dart';
import 'package:ecommerce_app/core/utils/text/brand_title_text_with_verified_icon.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';

class FeaturedBrand extends StatelessWidget {
  const FeaturedBrand({super.key, required this.isDark,  this.showBorder=false});

  final bool isDark;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsetsGeometry.all(AppSizes.sm),
      showBorder: showBorder,
      borderColor: isDark?AppColors.grey:AppColors.grey,
      backgroundColor: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularImage(
            image: AppImages.nikeLogo,
            isNetworkImage: false,
            backgroundColor: Colors.transparent,
            overlayColor: isDark ? AppColors.white : AppColors.black,
          ),
          const HorizentalSpace(width: AppSizes.spaceBtwItems / 2),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BrandTitleWithVerifiedIcon(
                title: "Nike",
                brandTextSize: TextSizes.large,
              ),
              Text(
                "20 Products",
          
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: AppColors.darkGrey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
