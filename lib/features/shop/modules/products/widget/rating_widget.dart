import 'package:ecommerce_app/core/style/spacing/horizental_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/circular_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({super.key, required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Iconsax.star5, color: AppColors.salePercentageColor),
            const HorizentalSpace(width: 6),
            Text('5.0 (199)', style: theme.textTheme.labelLarge),
            const HorizentalSpace(width: 8),
            TCircularContainer(
              width: 40,
              height: 24,
              radius: 12,
              backgroundColor: AppColors.salePercentageColor,
              child: Center(
                child: Text(
                  '78%',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
        IconButton(onPressed: () {}, icon: const Icon(Iconsax.share)),
      ],
    );
  }
}
