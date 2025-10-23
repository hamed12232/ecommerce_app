import 'package:ecommerce_app/core/layout/grid_layout.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/product_card_vertical.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/widget/brand_show_case.dart';
import 'package:flutter/material.dart';

class CategoryTabBar extends StatelessWidget {
  const CategoryTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              const BrandShowCase(),

              const BrandShowCase(),
              const VerticalSpace(height: AppSizes.spaceBtwInputFields*2),
              const SectionHeading(
                title: AppTextStrings.storeScreenYouMightLike,
              ),
              GridLayout(
                itemCount: 4,

                itemBuilder: (context, index) {
                  return const ProductCardVertical();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
