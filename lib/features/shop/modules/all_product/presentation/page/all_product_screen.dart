import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/presentation/widget/sort_drop_down.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/popular_products.dart';
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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppSizes.defaultSpace),
              child: SortDropdown(),
            ),
            VerticalSpace(height: AppSizes.spaceBtwItems),
            PopularProducts(),
          ],
        ),
      ),
    );
  }
}
