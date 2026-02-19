import 'package:ecommerce_app/core/layout/grid_layout.dart';
import 'package:ecommerce_app/core/widgets/shimmers/brand_shimmer.dart';
import 'package:ecommerce_app/features/shop/modules/brand/presentation/controller/cubit/brand_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/brand/presentation/page/brand_product.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/widget/feature_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandFeaturedBlocBuilder extends StatelessWidget {
  const BrandFeaturedBlocBuilder({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandCubit, BrandState>(
      builder: (context, brandState) {
        if (brandState.status == BrandStatus.loading) {
          return const BrandShimmer();
        }
        return GridLayout(
          itemCount: brandState.featuredBrands.length > 4
              ? 4
              : brandState.featuredBrands.length,
          mainAxisExtent: 80,
          itemBuilder: (context, index) {
            final brand = brandState.featuredBrands[index];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                BrandProduct.routeName,
                arguments: brand,
              ),
              child: FeaturedBrand(
                isDark: isDark,
                showBorder: false,
                brand: brand,
              ),
            );
          },
        );
      },
    );
  }
}
