import 'package:ecommerce_app/core/layout/grid_layout.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/presentation/cubit/all_products_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/presentation/widget/sort_drop_down.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/entities/brand_entity.dart';
import 'package:ecommerce_app/features/shop/modules/brand/presentation/controller/cubit/brand_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/product_card_vertical.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/widget/feature_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandProduct extends StatelessWidget {
  const BrandProduct({super.key, required this.brand});

  static const String routeName = '/brand_product';

  final BrandEntity brand;

  @override
  Widget build(BuildContext context) {
    bool isDark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          brand.name,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: FeaturedBrand(
                isDark: isDark,
                showBorder: true,
                brand: brand,
              ),
            ),
            const VerticalSpace(height: AppSizes.spaceBtwItems),
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: SortDropdown(
                onChanged: (value) {
                  context.read<AllProductsCubit>().sortProducts(value!);
                },
              ),
            ),
            const VerticalSpace(height: AppSizes.spaceBtwItems),
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: BlocBuilder<BrandCubit, BrandState>(
                builder: (context, state) {
                  if (state.status == BrandStatus.loading) {
                    return const VerticalProductShimmer();
                  }

                  if (state.status == BrandStatus.error) {
                    return Center(child: Text(state.error ?? 'Unknown Error'));
                  }

                  if (state.brandProducts.isEmpty) {
                    return Center(
                      child: Text(
                        'No Products Found',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }

                  return GridLayout(
                    itemCount: state.brandProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCardVertical(
                        product: state.brandProducts[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
