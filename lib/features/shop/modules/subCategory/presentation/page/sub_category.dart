import 'package:ecommerce_app/core/style/spacing/horizental_space.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/images/rounded_images.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/features/shop/modules/subCategory/presentation/widget/product_card_horizental.dart';
import 'package:flutter/material.dart';

class SubCategory extends StatelessWidget {
  const SubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,

        title: Text(
          'Sports',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const RoundedImage(imageUrl: AppImages.promoBanner1),
              const VerticalSpace(height: AppSizes.spaceBtwSections),

              const SectionHeading(
                title: AppTextStrings.sportsShoes,
                buttonTitle: "View all",
                showActionButton: true,
              ),
              const VerticalSpace(height: AppSizes.spaceBtwItems / 2),
              SizedBox(
                height: 120,

                child: ListView.separated(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => const ProductCardHorizontal(),
                  separatorBuilder: (_, index) =>
                      const HorizentalSpace(width: AppSizes.spaceBtwItems),
                ),
              ),
              const VerticalSpace(height: AppSizes.spaceBtwSections),

              const SectionHeading(
                title: AppTextStrings.trackSuit,
                buttonTitle: "View all",
                showActionButton: true,
              ),
              const VerticalSpace(height: AppSizes.spaceBtwItems / 2),
              SizedBox(
                height: 120,

                child: ListView.separated(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => const ProductCardHorizontal(),
                  separatorBuilder: (_, index) =>
                      const HorizentalSpace(width: AppSizes.spaceBtwItems),
                ),
              ),
              const VerticalSpace(height: AppSizes.spaceBtwSections),

              const SectionHeading(
                title: AppTextStrings.sportsEquipment,
                buttonTitle: "View all",
                showActionButton: true,
              ),
              const VerticalSpace(height: AppSizes.spaceBtwItems / 2),
              SizedBox(
                height: 120,
                child: ListView.separated(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => const ProductCardHorizontal(),
                  separatorBuilder: (_, index) =>
                      const HorizentalSpace(width: AppSizes.spaceBtwItems),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
