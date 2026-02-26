import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

class HorizontalProductShimmer extends StatelessWidget {
  const HorizontalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSizes.spaceBtwSections),
        height: 120,
        child: ListView.separated(
          itemCount: itemCount,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) =>
              const SizedBox(width: AppSizes.spaceBtwItems),
          itemBuilder: (_, __) => const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Image
              ShimmerEffect(width: 120, height: 120),
              SizedBox(width: AppSizes.spaceBtwItems),

              /// Text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: AppSizes.spaceBtwItems / 2),
                  ShimmerEffect(width: 160, height: 15),
                  SizedBox(height: AppSizes.spaceBtwItems / 2),
                  ShimmerEffect(width: 110, height: 15),
                  SizedBox(height: AppSizes.spaceBtwItems / 2),
                  ShimmerEffect(width: 80, height: 15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
