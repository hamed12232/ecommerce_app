import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductQuantityWithAddRemoveButton extends StatelessWidget {
  const ProductQuantityWithAddRemoveButton({
    super.key,
    required this.quantity,
    this.add,
    this.remove,
    this.addButtonColor = AppColors.black,
  });

  final Color addButtonColor;
  final int quantity;
  final VoidCallback? add;
  final VoidCallback? remove;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: 160,
      height: 73,
      radius: AppSizes.cardRadiusMd,
      backgroundColor: Colors.transparent,

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
                onPressed: remove,
                icon: const Icon(
                  Iconsax.minus,
                  size: AppSizes.iconMd,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          Text('$quantity', style: Theme.of(context).textTheme.titleLarge),
          Container(
            decoration: BoxDecoration(
              color: addButtonColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: IconButton(
                onPressed: add,
                icon: const Icon(
                  Iconsax.add,
                  size: AppSizes.iconMd,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
