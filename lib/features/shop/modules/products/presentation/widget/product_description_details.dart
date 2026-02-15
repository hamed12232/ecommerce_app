import 'package:ecommerce_app/core/style/spacing/horizental_space.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/enums.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/pricing_calculator.dart';
import 'package:ecommerce_app/core/utils/images/circular_image.dart';
import 'package:ecommerce_app/core/utils/text/brand_title_text_with_verified_icon.dart';
import 'package:ecommerce_app/core/utils/text/product_price_text.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class ProductDescriptionDetails extends StatelessWidget {
  const ProductDescriptionDetails({
    super.key,
    required this.theme,
    required this.dark,
    required this.product,
  });

  final ThemeData theme;
  final bool dark;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final brandImage = product.brand?.image ?? '';
    final isBrandNetwork = brandImage.startsWith('http');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (product.salePrice != null && product.salePrice! > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.salePercentageColor,
                  borderRadius: BorderRadius.circular(AppSizes.sm),
                ),
                child: Text(
                  '${PricingCalculator.calculateSalePercentage(product.price, product.salePrice!)}%',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            if (product.salePrice != null && product.salePrice! > 0)
              const HorizentalSpace(width: AppSizes.sm),
          ],
        ),
        const VerticalSpace(height: AppSizes.sm),

        /// -- Price
        ProductPriceText(
          price: PricingCalculator.getProductPrice(product),
          isLarge: true,
        ),
        const VerticalSpace(height: AppSizes.sm),

        /// -- Title
        Text(product.title, style: theme.textTheme.labelLarge),

        const VerticalSpace(height: AppSizes.sm),

        /// -- Stock & SKU
        Text(
          'Stock : ${PricingCalculator.getProductStockStatus(product.stock)}',
          style: theme.textTheme.labelLarge,
        ),
        if (product.sku != null && product.sku!.isNotEmpty) ...[
          const VerticalSpace(height: AppSizes.xs),
          Text('SKU : ${product.sku}', style: theme.textTheme.labelMedium),
        ],

        const VerticalSpace(height: AppSizes.sm),

        /// -- Brand row
        if (product.brand != null)
          Row(
            children: [
              const HorizentalSpace(width: 6),
              CircularImage(
                image: brandImage,
                isNetworkImage: isBrandNetwork,
                width: 40,
                backgroundColor: Colors.transparent,
                overlayColor: isBrandNetwork
                    ? null
                    : (dark ? AppColors.white : AppColors.black),
              ),
              BrandTitleWithVerifiedIcon(
                title: product.brand!.name,
                brandTextSize: TextSizes.large,
              ),
            ],
          ),
      ],
    );
  }
}
