
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/widgets/cart_menu_icon.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
          AppTextStrings.homeAppbarTitle,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.apply(color: AppColors.grey),
        ),
        Text(
          AppTextStrings.homeAppbarSubTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.apply(color: AppColors.white),
        ),
          ],
        ),
          const CartMenuIcon(),
      ],
    );
  }
}