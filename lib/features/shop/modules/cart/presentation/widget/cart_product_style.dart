import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/images/rounded_images.dart';
import 'package:ecommerce_app/core/utils/text/brand_title_text_with_verified_icon.dart';
import 'package:ecommerce_app/core/utils/text/product_title_text.dart';
import 'package:ecommerce_app/features/shop/modules/cart/data/models/cart_item_model.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.item});

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        /// 1 - Image
        RoundedImage(
          width: 60,
          height: 60,
          imageUrl: item.image ?? '',
          isNetworkImage: true,
          padding: const EdgeInsets.all(AppSizes.sm),
          backgroundColor: dark ? AppColors.darkerGrey : AppColors.white,
        ),
        const SizedBox(width: AppSizes.spaceBtwItems),

        /// 2 - Title, Price, & Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Brand and Title
              BrandTitleWithVerifiedIcon(title: item.brandName ?? ''),
              Flexible(
                child: ProductTitleText(title: item.title ?? '', maxLines: 1),
              ),

              /// Attributes
              Text.rich(
                TextSpan(
                  children: (item.selectedVariation ?? {}).entries
                      .map(
                        (e) => TextSpan(
                          children: [
                            TextSpan(
                              text: ' ${e.key} ',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: '${e.value} ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
