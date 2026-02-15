import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/text/product_price_text.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_variation_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/controller/cubit/product_variation_state.dart';
import 'package:flutter/material.dart';

class SelectedVariationContainer extends StatelessWidget {
  const SelectedVariationContainer({
    super.key,
    required this.theme,
    required this.dark,
    required this.state,
  });

  final ThemeData theme;
  final bool dark;
  final ProductVariationState state;

  @override
  Widget build(BuildContext context) {
    final variation = state.selectedVariation;
    final isVariationSelected = variation != null;

    return RoundedContainer(
      backgroundColor: dark ? AppColors.darkGrey : AppColors.grey,
      padding: const EdgeInsets.all(AppSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SectionHeading(title: 'Variation', showActionButton: false),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Price : ', style: TextStyle(fontSize: 12)),
                      if (isVariationSelected)
                        ProductPriceText(
                          price: _getVariationPrice(variation),
                          isLarge: false,
                        )
                      else
                        const Text('Not Selected'),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Stock : ', style: TextStyle(fontSize: 12)),
                      Text(
                        isVariationSelected
                            ? variation.stock.toString()
                            : 'In Stock',
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          if (isVariationSelected &&
              variation.description != null &&
              variation.description!.isNotEmpty) ...[
            const VerticalSpace(height: AppSizes.sm),
            Text(
              variation.description!,
              style: theme.textTheme.bodySmall,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  String _getVariationPrice(ProductVariationModel variation) {
    if (variation.salePrice != null && variation.salePrice! > 0) {
      return '${variation.salePrice}';
    }
    return '${variation.price}';
  }
}
