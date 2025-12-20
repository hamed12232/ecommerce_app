import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/widgets/loaders/animation_loader.dart';
import 'package:flutter/material.dart';


/// A utility class for managing a full-screen loading dialog.
class AppFullScreenLoader {
  /// Open a full-screen loading dialog with a given text and animation.
  /// This method doesn't return anything.
  ///
  /// Parameters:
  ///   - text: The text to be displayed in the loading dialog.
  ///   - animation: The Lottie animation to be shown.
  static void openLoadingDialog(String text, String animation,BuildContext context) {
    showDialog(
      context: context, // Use Get.overlayContext for overlay dialogs
      barrierDismissible: false, // The dialog can't be dismissed by tapping outside it
      builder: (_) => PopScope(
        canPop: false, // Disable popping with the back button
        child: Container(
          color: AppHelperFunctions.isDarkMode(context) ? AppColors.darkContainer : AppColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250), // Adjust the spacing as needed
              AppAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }
  static  void deleteAccountWarningPopup(BuildContext context, Function() onConfirm) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
            'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
          ),
          actions: [
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: onConfirm ,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
                child: Text('Delete'),
              ),
            ),
          ],
        );
      },
    );
  }

  static void popUpCircular(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: AppHelperFunctions.isDarkMode(context) ? AppColors.darkContainer : AppColors.white,
          width: double.infinity,
          height: double.infinity,
          child: const AppAnimationLoaderWidget(text: 'Loading...', animation: 'assets/animations/loading.json'),
        ),
      ),
    );
  }

  /// Stop the currently open loading dialog.
  /// This method doesn't return anything.
  static stopLoading(BuildContext context) {
    Navigator.of(context).pop(); // Close the dialog using the Navigator
  }
}
