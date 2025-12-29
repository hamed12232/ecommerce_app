import 'package:ecommerce_app/core/layout/grid_layout.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/presentation/widget/sort_drop_down.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/product_card_vertical.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  static const String routeName = '/all-products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,

        title: Text(
          'Popular Products',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(AppSizes.defaultSpace),
              child: SortDropdown(),
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
