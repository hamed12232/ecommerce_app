import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

class TListTileShimmer extends StatelessWidget {
  const TListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            ShimmerEffect(width: 50, height: 50, radius: 50),
            SizedBox(width: AppSizes.spaceBtwItems),
            Column(
              children: [
                ShimmerEffect(width: 100, height: 15),
                SizedBox(height: AppSizes.spaceBtwItems / 2),
                ShimmerEffect(width: 80, height: 12),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
