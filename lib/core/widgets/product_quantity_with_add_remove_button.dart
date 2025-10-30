import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductQuantityWithAddRemoveButton extends StatefulWidget {
  const ProductQuantityWithAddRemoveButton({super.key, required this.theme,  this.addButtonColor=AppColors.black});
  final Color addButtonColor;

  final ThemeData theme;

  @override
  State<ProductQuantityWithAddRemoveButton> createState() =>
      _ProductQuantityWithAddRemoveButtonState();
}

class _ProductQuantityWithAddRemoveButtonState
    extends State<ProductQuantityWithAddRemoveButton> {
  int _quantity = 0;

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
                onPressed: () =>
                    setState(() => _quantity = (_quantity - 1).clamp(0, 999)),
                icon: const Icon(
                  Iconsax.minus,
                  size: AppSizes.iconMd,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          Text('$_quantity', style: widget.theme.textTheme.titleLarge),
          Container(
            decoration:  BoxDecoration(
              color: widget.addButtonColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: IconButton(
                onPressed: () =>
                    setState(() => _quantity = (_quantity + 1).clamp(0, 999)),
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
