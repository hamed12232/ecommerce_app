import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CartMenuIcon extends StatelessWidget {
  const CartMenuIcon({super.key,this.colorIcon = AppColors.white});
final Color colorIcon ;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // IconButton for navigating to the CartScreen
        IconButton(
          onPressed: () {},
          icon:  Icon(Iconsax.shopping_bag, color: colorIcon),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: AppSizes.fontSizeLg,
            height: AppSizes.fontSizeLg,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                "2",
                style: Theme.of(context).textTheme.labelLarge!.apply(
                  color: AppColors.white,
                  fontSizeFactor: 0.8,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
