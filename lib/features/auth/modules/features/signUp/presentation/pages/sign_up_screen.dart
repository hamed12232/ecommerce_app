import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/style/spacing_style.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/core/widgets/custom_password_text_field.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/features/auth/modules/features/signUp/presentation/widgets/agree_policy_checkbox.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/widgets/custom_divider_sign_in_methods.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/widgets/custom_sign_in_methods_buttons.dart';
import 'package:ecommerce_app/features/auth/modules/features/verify_email/presentation/pages/verify_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // responsive helpers
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: SpacingStyle.defaultPaddingWithTop,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpace(height: AppSizes.xl),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Iconsax.arrow_left, size: 22),
              ),
              const VerticalSpace(height: AppSizes.sm),
              Text(
                "Let's create your account",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const VerticalSpace(height: AppSizes.spaceBtwSections),

              // First & Last name side-by-side
              Row(
                children: [
                  Flexible(
                    child: MyTextFormField(
                      hintText: 'First Name',
                      isObsecure: false,
                      controller: firstNameController,
                      prefixIcon: const Icon(Iconsax.user, size: 18),
                    ),
                  ),
                  const SizedBox(width: AppSizes.sm),
                  Flexible(
                    child: MyTextFormField(
                      hintText: 'Last Name',
                      isObsecure: false,
                      controller: lastNameController,
                      prefixIcon: const Icon(Iconsax.user, size: 18),
                    ),
                  ),
                ],
              ),
              const VerticalSpace(height: AppSizes.spaceBtwInputFields),

              // Username
              MyTextFormField(
                hintText: 'Username',
                isObsecure: false,
                controller: usernameController,
                prefixIcon: const Icon(Iconsax.user_tag, size: 18),
              ),
              const VerticalSpace(height: AppSizes.spaceBtwInputFields),

              // Email
              MyTextFormField(
                hintText: AppTextStrings.tEmail,
                isObsecure: false,
                controller: emailController,
                prefixIcon: const Icon(Iconsax.sms, size: 18),
              ),
              const VerticalSpace(height: AppSizes.spaceBtwInputFields),
              // Phone
              MyTextFormField(
                hintText: AppTextStrings.tPhoneNo,
                isObsecure: false,
                controller: phoneController,
                prefixIcon: const Icon(Iconsax.call, size: 18),
              ),
              const VerticalSpace(height: AppSizes.spaceBtwInputFields),
              // Password
              CustomPasswordTextField(
                passwordEditingController: passwordController,
                text: AppTextStrings.password,
                prefixIcon: const Icon(Iconsax.password_check, size: 18),
              ),
              const VerticalSpace(height: AppSizes.spaceBtwSections / 2),

              // Agree to privacy policy
              const AgreePolicyCheckbox(),
              const VerticalSpace(height: AppSizes.spaceBtwSections),

              // Create Account button
              CustomButton(
                text: 'Create Account',
                onPressed: () {
                  AppHelperFunctions.navigateToScreen(context,VerifyEmailScreen(email: emailController.text,title: AppTextStrings.confirmEmail,
                  
                  subtitle: AppTextStrings.confirmEmailSubTitle,
                  buttonTitle: AppTextStrings.tContinue,
                  ));
                },
                fontSize: 16,
              ),
              const VerticalSpace(height: AppSizes.spaceBtwSections),

              // OR divider and social buttons
              const CustomDividerSignInMethods(),
              const VerticalSpace(height: AppSizes.spaceBtwSections),
              const CustomSignInMethodsButtons(),
              const VerticalSpace(height: AppSizes.xl),
            ],
          ),
        ),
      ),
    );
  }
}
