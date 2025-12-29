import 'package:ecommerce_app/core/layout/grid_layout.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/product_card_vertical.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/shop/modules/wishlist/presentation/widgets/wishlist_section_heading.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  static const String routeName = '/wishlist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: AppSizes.appBarHeight,
          left: AppSizes.defaultSpace,
          right: AppSizes.defaultSpace,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const WishlistSectionHeading(
                title: AppTextStrings.wishlistAppBar,
              ),
              const VerticalSpace(height: AppSizes.spaceBtwInputFields),
              GridLayout(
                itemCount: 10,

                itemBuilder: (context, index) {
                  return ProductCardVertical(product: ProductEntity.empty());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
