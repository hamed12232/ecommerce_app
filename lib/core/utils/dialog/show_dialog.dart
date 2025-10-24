import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:flutter/material.dart';

class ShowDialog {
  static  void showLogoutModal(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text(AppTextStrings.tLogoutDialogHeading),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}