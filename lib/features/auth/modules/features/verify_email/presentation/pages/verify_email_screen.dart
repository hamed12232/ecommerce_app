import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/style/spacing_style.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final height = AppHelperFunctions.screenHeight(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: SpacingStyle.defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Close icon (top-right)
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Iconsax.close_circle, size: AppSizes.iconLg),
                ),
              ),

              // Illustration
              Center(
                child: Image.asset(
                  AppImages.forgetPasswordIllustration,
                  height: height * 0.36,
                  fit: BoxFit.contain,
                ),
              ),
              const VerticalSpace(height: AppSizes.spaceBtwSections),

              // Title
              Text(
                AppTextStrings.confirmEmail,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const VerticalSpace(height: AppSizes.sm),

              // Email shown
              Text(
                email,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const VerticalSpace(height: AppSizes.sm),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultSpace,
                ),
                child: Text(
                  AppTextStrings.confirmEmailSubTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),

              const VerticalSpace(height: AppSizes.lg),

              // Continue button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultSpace,
                ),
                child: CustomButton(
                  text: AppTextStrings.tContinue,
                  onPressed: () {
                    // default behaviour: pop to previous screen
                    Navigator.of(context).pop();
                  },
                ),
              ),

              const VerticalSpace(height: AppSizes.md),

              // Resend email
              Center(
                child: TextButton(
                  onPressed: () {
                    // TODO: implement resend email
                  },
                  child: Text(
                    AppTextStrings.resendEmail,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
