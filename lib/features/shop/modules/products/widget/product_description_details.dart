import 'package:ecommerce_app/core/style/spacing/horizental_space.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/enums.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/images/circular_image.dart';
import 'package:ecommerce_app/core/utils/text/brand_title_text_with_verified_icon.dart';
import 'package:ecommerce_app/core/utils/text/product_price_text.dart';
import 'package:flutter/material.dart';

class ProductDescriptionDetails extends StatelessWidget {
  const ProductDescriptionDetails({
    super.key,
    required this.theme,
    required this.dark,
  });
  final ThemeData theme;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProductPriceText(price: '122.6 - 334.0', isLarge: true),
        const VerticalSpace(height: AppSizes.sm),
        Text('Green Nike sports shoe', style: theme.textTheme.labelLarge),

        const VerticalSpace(height: AppSizes.sm),
        Text('Stock : In Stock', style: theme.textTheme.labelLarge?.copyWith()),
        const VerticalSpace(height: AppSizes.sm),
        Row(
          children: [
            const HorizentalSpace(width: 6),
            CircularImage(
              image: AppImages.nikeLogo,
              isNetworkImage: false,
              width: 40,
              backgroundColor: Colors.transparent,
              overlayColor: dark ? AppColors.white : AppColors.black,
            ),
            const BrandTitleWithVerifiedIcon(
              title: "Nike",
              brandTextSize: TextSizes.large,
            ),
          ],
        ),
      ],
    );
  }
}
