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
      color: widget.dark ? AppColors.dark : AppColors.lightBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Quantity controls
          RoundedContainer(
            width: 160,
            height: 73,
            radius: AppSizes.cardRadiusMd,
            backgroundColor: 
                 Colors.transparent,
                
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                
                  decoration: const BoxDecoration(
                    color: AppColors.darkGrey,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () => setState(() => _quantity = (_quantity - 1).clamp(0, 999)),
                      icon: const Icon(Iconsax.minus,size: AppSizes.iconMd,
                      color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Text('$_quantity', style: widget.theme.textTheme.titleLarge),
                  Container(
                
                  decoration: const BoxDecoration(
                    color: AppColors.darkBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IconButton(
                      onPressed: () => setState(() => _quantity = (_quantity + 1).clamp(0, 999)),
                      icon: const Icon(Iconsax.add,size: AppSizes.iconMd,
                      color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const HorizentalSpace(width: AppSizes.sm),

          // Add to Bag
          RoundedContainer(
            height: 55,
            width: AppSizes.productItemHeight,
            radius: AppSizes.cardRadiusMd,
            backgroundColor: 
                AppColors.darkBackground,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Iconsax.shopping_bag, color: AppColors.white),
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
        ],
      ),
    );
  }
}
