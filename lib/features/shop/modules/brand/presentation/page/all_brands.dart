import 'package:ecommerce_app/core/layout/grid_layout.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/core/widgets/shimmers/brand_shimmer.dart';
import 'package:ecommerce_app/features/shop/modules/brand/presentation/controller/cubit/brand_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/brand/presentation/page/brand_product.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/widget/feature_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});
  static const String routeName = '/all_brands';

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Brand', style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SectionHeading(
                title: AppTextStrings.brands,
                showActionButton: false,
              ),

              const VerticalSpace(height: AppSizes.spaceBtwItems / 1.5),
              BlocBuilder<BrandCubit, BrandState>(
                buildWhen: (previous, current) =>
                    current.status != previous.status,
                builder: (context, state) {
                  if (state.status == BrandStatus.loading) {
                    return const BrandShimmer(itemCount: 10);
                  }

                  if (state.status == BrandStatus.error) {
                    return Center(child: Text(state.error ?? 'Unknown Error'));
                  }

                  if (state.brands.isEmpty) {
                    return Center(
                      child: Text(
                        'No Brands Found',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }

                  return GridLayout(
                    itemCount: state.brands.length,
                    mainAxisExtent: 80,
                    itemBuilder: (context, index) {
                      final brand = state.brands[index];
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          BrandProduct.routeName,
                          arguments: brand,
                        ),
                        child: FeaturedBrand(
                          isDark: isDark,
                          showBorder: true,
                          brand: brand,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
