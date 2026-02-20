import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

class TBoxesShimmer extends StatelessWidget {
  const TBoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: ShimmerEffect(width: 150, height: 110)),
            SizedBox(width: AppSizes.spaceBtwItems),
            Expanded(child: ShimmerEffect(width: 150, height: 110)),
            SizedBox(width: AppSizes.spaceBtwItems),
            Expanded(child: ShimmerEffect(width: 150, height: 110)),
          ],
        ),
      ],
    );
  }
}
