import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/style/spacing_style.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/popups/loaders.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/features/auth/modules/features/forget_password/presentation/controller/cubit/forget_password_cubit.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});
  static const String routeName = '/reset-password';
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
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Iconsax.close_circle, size: AppSizes.iconLg),
                ),
              ),

              Center(
                child: Image.asset(
                  AppImages.forgetPasswordIllustration,
                  height: height * 0.36,
                  fit: BoxFit.contain,
                ),
              ),
              const VerticalSpace(height: AppSizes.spaceBtwSections),

              Text(
                AppTextStrings.tResetPasswordTitle,
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
                  AppTextStrings.tResetPasswordSubTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.darkGrey),
                ),
              ),

              const VerticalSpace(height: AppSizes.lg),
              // Continue button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultSpace,
                ),
                child: CustomButton(
                  text: AppTextStrings.tdone,
                  onPressed: () {
                    AppLoaders.successSnackBar(
                      title: 'Success',
                      message: 'Password reset successfully',
                      context: context,
                    );
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                ),
              ),

              const VerticalSpace(height: AppSizes.md),

              // Resend email
              Center(
                child: TextButton(
                  onPressed: () {
                    context.read<ForgetPasswordCubit>().sendPasswordResetEmail(
                      email,
                    );
                      AppLoaders.successSnackBar(
                      title: 'Success',
                      message: 'Password reset email sent successfully',
                      context: context,
                    );
                  },
                  child: Text(
                    AppTextStrings.resendEmail,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColors.borderPrimary,
                    ),
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
