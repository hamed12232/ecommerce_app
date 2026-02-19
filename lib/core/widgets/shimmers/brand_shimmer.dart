import 'package:ecommerce_app/core/layout/grid_layout.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

class BrandShimmer extends StatelessWidget {
  const BrandShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Image
          ShimmerEffect(width: 56, height: 56, radius: 56),
          SizedBox(width: AppSizes.spaceBtwItems / 2),

          /// Text
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerEffect(width: 80, height: 12),
              SizedBox(height: AppSizes.spaceBtwItems / 2),
              ShimmerEffect(width: 50, height: 8),
            ],
          ),
        ],
      ),
    );
  }
}
