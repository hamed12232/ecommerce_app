
import 'package:ecommerce_app/core/style/spacing/horizental_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TopTitleBar extends StatelessWidget {
  const TopTitleBar({
    super.key,
    required this.dark,
    required this.theme, required this.title,
  });

  final bool dark;
  final ThemeData theme;
  final String title ;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(
            Iconsax.arrow_left,
            color: dark
                ? AppColors.textDarkPrimary
                : AppColors.textPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const HorizentalSpace(width: AppSizes.lg),
        Text(
        title,
          style: theme.textTheme.headlineMedium,
        ),
      ],
    );
  }
}
