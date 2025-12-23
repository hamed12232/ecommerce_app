import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/images/circular_image.dart';
import 'package:ecommerce_app/core/utils/text/brand_title_text.dart';
import 'package:flutter/material.dart';


class VerticalImageAndText extends StatelessWidget {
  const VerticalImageAndText({
    super.key,
    this.onTap,
    required this.image,
    required this.title,
    this.backgroundColor,
    this.textColor = AppColors.white,
  });

  final Color textColor;
  final String image, title;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: AppSizes.spaceBtwItems),
        child: Column(
          children: [
            /// Circular Icon
            CircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: AppSizes.sm * 1.4,
              backgroundColor: backgroundColor,
              isNetworkImage: true,
              overlayColor: dark ? AppColors.white : AppColors.dark,
            ),
            const SizedBox(height: AppSizes.spaceBtwItems / 2),

            /// Text
            SizedBox(
              width: 55,
              child: BrandTitleText(title: title, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
