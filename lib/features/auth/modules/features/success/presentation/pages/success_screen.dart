import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/style/spacing_style.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, this.image, this.onPressed});

  static const String routeName = '/success';

  final String? image;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final height = AppHelperFunctions.screenHeight(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: SpacingStyle.defaultPaddingWithTop,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const VerticalSpace(height: AppSizes.lg),

              // Illustration
              Center(
                child: Lottie.asset(
                  image ?? AppImages.successfullyRegisterAnimation,
                  height: height * 0.36,
                  fit: BoxFit.contain,
                ),
              ),

              const VerticalSpace(height: AppSizes.spaceBtwSections),

              // Title
              Text(
                AppTextStrings.yourAccountCreatedTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ),

              const VerticalSpace(height: AppSizes.sm),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultSpace,
                ),
                child: Text(
                  AppTextStrings.yourAccountCreatedSubTitle,
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
                  onPressed: onPressed ?? () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginScreen.routeName,
                      (route) => false,
                    );
                  },
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
