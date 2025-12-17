import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/style/spacing_style.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/features/auth/modules/features/verify_email/presentation/pages/verify_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  static const String routeName = '/forget-password';

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: SpacingStyle.defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top-right close icon
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Iconsax.close_square, size: 22),
                ),
              ),

              const VerticalSpace(height: AppSizes.lg),

              Text(
                'Forget password',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const VerticalSpace(height: AppSizes.sm),

              // Subtitle
              Text(
                "Don't worry sometimes people can forget too, enter your email and we will send you a password reset link.",
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
              const VerticalSpace(height: AppSizes.spaceBtwSections),

              // Email field
              MyTextFormField(
                hintText: AppTextStrings.tEmail,
                isObsecure: false,
                controller: emailController,
                prefixIcon: const Icon(Iconsax.direct_right, size: 18),
              ),
              const VerticalSpace(height: AppSizes.spaceBtwSections),

              // Submit button
              CustomButton(
                text: 'Submit',
                onPressed: () {
                  AppHelperFunctions.navigateToScreen(
                    context,
                    VerifyEmailScreen(
                      email: emailController.text,
                      title: AppTextStrings.tResetPasswordTitle,
                      subtitle: AppTextStrings.tResetPasswordSubTitle,
                      buttonTitle: AppTextStrings.tdone,
                      isForgetPasswordScreen: true,
                    ),
                  );
                },
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
