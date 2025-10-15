import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/widgets/cart_menu_icon.dart';
import 'package:flutter/material.dart';

class StoreAppBar extends StatelessWidget {
  const StoreAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Color colorIcon = AppHelperFunctions.isDarkMode(context)
        ? Colors.white
        : Colors.black;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTextStrings.homeAppbarstore,
              style: Theme.of(context).textTheme.displayMedium!.apply(),
            ),
          ],
        ),
        CartMenuIcon(colorIcon: colorIcon),
      ],
    );
  }
}
