import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';

class CustomDividerSignInMethods extends StatelessWidget {
  const CustomDividerSignInMethods({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Divider(
            thickness: 1,
            indent: 50,
            color: Colors.grey.withValues(alpha: 0.3),
            endIndent: 10,
          ),
        ),
        Text(
          AppTextStrings.orSignInWith,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Flexible(
          child: Divider(
            thickness: 1,
            indent: 10,
            color: Colors.grey.withValues(alpha: 0.3),
            endIndent: 50,
          ),
        ),
      ],
    );
  }
}
