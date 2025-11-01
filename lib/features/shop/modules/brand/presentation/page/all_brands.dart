import 'package:ecommerce_app/core/layout/grid_layout.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/widget/feature_brand.dart';
import 'package:flutter/material.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,

        title: Text(
          'Brand',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
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
              GridLayout(
                itemCount: 10,
                mainAxisExtent: 80,
                itemBuilder: (context, index) {
                  return FeaturedBrand(isDark: isDark, showBorder: true);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
