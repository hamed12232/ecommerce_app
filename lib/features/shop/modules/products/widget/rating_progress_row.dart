import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class RatingProgressRow extends StatelessWidget {
  const RatingProgressRow({super.key, required this.theme, required this.value});
  final ThemeData theme;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(value, style: theme.textTheme.bodyMedium)),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: AppHelperFunctions.screenWidth(context) * 0.8,
            child: LinearProgressIndicator(
              value: 0.5,
              minHeight: 11,
              backgroundColor: AppColors.grey,
              borderRadius: BorderRadius.circular(7),
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
