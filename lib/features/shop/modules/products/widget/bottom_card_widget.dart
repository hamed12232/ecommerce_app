import 'package:ecommerce_app/core/style/spacing/horizental_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomCardWidget extends StatefulWidget {
  const BottomCardWidget({super.key, required this.dark, required this.theme});
  final bool dark;
  final ThemeData theme;

  @override
  State<BottomCardWidget> createState() => _BottomCardWidgetState();
}

class _BottomCardWidgetState extends State<BottomCardWidget> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.defaultSpace,
        vertical: AppSizes.sm,
      ),
      color: widget.dark ? AppColors.darkBackground : AppColors.lightBackground,
      child: Row(
        children: [
          // Quantity controls
          RoundedContainer(
            width: 140,
            height: 56,
            radius: AppSizes.cardRadiusMd,
            backgroundColor: widget.dark
                ? AppColors.darkContainer
                : AppColors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () =>
                      setState(() => _quantity = (_quantity - 1).clamp(0, 999)),
                  icon: const Icon(Icons.remove),
                ),
                Text('$_quantity', style: widget.theme.textTheme.titleLarge),
                IconButton(
                  onPressed: () =>
                      setState(() => _quantity = (_quantity + 1).clamp(0, 999)),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          const HorizentalSpace(width: AppSizes.sm),

          // Add to Bag
          Expanded(
            child: RoundedContainer(
              height: 56,
              radius: AppSizes.cardRadiusMd,
              backgroundColor: AppColors.dashboardAppbarBackground,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.bag, color: AppColors.white),
                  const HorizentalSpace(width: 8),
                  Text(
                    'Add to Bag',
                    style: widget.theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
