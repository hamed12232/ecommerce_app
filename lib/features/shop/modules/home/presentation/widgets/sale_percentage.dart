
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';

class SalePercentage extends StatelessWidget {
  const SalePercentage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      radius: AppSizes.sm,
      backgroundColor: AppColors.salePercentageColor.withValues(
        alpha: 0.8,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.sm,
        vertical: AppSizes.xs,
      ),
      child: Text(
        '50%',
        style: (Theme.of(context).textTheme.labelLarge ??
                const TextStyle(color: AppColors.black))
            .apply(color: AppColors.black),
      ),
    );
  }
}
