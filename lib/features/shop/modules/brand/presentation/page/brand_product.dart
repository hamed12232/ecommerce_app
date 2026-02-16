import 'package:ecommerce_app/core/layout/grid_layout.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/presentation/widget/sort_drop_down.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/product_card_vertical.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/widget/feature_brand.dart';
import 'package:flutter/material.dart';

class BrandProduct extends StatelessWidget {
  const BrandProduct({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const SizedBox(),

        title: Text('Nike', style: Theme.of(context).textTheme.displayMedium),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: FeaturedBrand(isDark: isDark, showBorder: true),
            ),
            const VerticalSpace(height: AppSizes.spaceBtwItems),
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: SortDropdown(onChanged: (value) {}),
            ),
            const VerticalSpace(height: AppSizes.spaceBtwItems),
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: GridLayout(
                itemCount: 10,

                itemBuilder: (context, index) {
                  return ProductCardVertical(product: ProductEntity.empty());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
