import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class ShowDialog {
  static void showLogoutModal(BuildContext context, VoidCallback onLogout) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? AppColors.darkContainer : AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Logout', style: Theme.of(context).textTheme.headlineSmall),
        content: Text(
          AppTextStrings.tLogoutDialogHeading,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onLogout();
            },
            child: Text(
              'Logout',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.apply(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
