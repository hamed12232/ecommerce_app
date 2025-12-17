import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/style/spacing_style.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_app/core/utils/popups/loaders.dart';
import 'package:ecommerce_app/core/utils/validators/validation.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/core/widgets/custom_password_text_field.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/widgets/custom_divider_sign_in_methods.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/widgets/custom_sign_in_methods_buttons.dart';
import 'package:ecommerce_app/features/auth/modules/features/signUp/presentation/controller/cubit/sign_up_cubit.dart';
import 'package:ecommerce_app/features/auth/modules/features/signUp/presentation/widgets/agree_policy_checkbox.dart';
import 'package:ecommerce_app/features/auth/modules/features/verify_email/presentation/pages/verify_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const String routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    return BlocListener<SignUpCubit, SignUpState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == SignUpStatus.loading) {
          AppFullScreenLoader.openLoadingDialog(
            'We Are Processing Your Data...',
            AppImages.docerAnimation,
            context,
          );
        } else if (state.status == SignUpStatus.success) {
          AppFullScreenLoader.stopLoading(context);
          AppLoaders.successSnackBar(
            message: 'Account created successfully!',
            context: context,
            title: 'Success',
          );
          Navigator.pushNamed(
            context,
            VerifyEmailScreen.routeName,
            arguments: {
              'email': cubit.emailController.text.trim(),
              'title': 'Verify your email',
              'subtitle': 'Please check your email for the verification message.',
              'buttonTitle': 'Verify',
              'isForgetPasswordScreen': false,
            },
          );
        } else if (state.status == SignUpStatus.error) {
          AppFullScreenLoader.stopLoading(context);
          AppLoaders.errorSnackBar(
            message: state.error ?? 'Something went wrong',
            context: context,
            title: 'Error',
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: cubit.formKey,
          child: Padding(
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
                  Row(
                    children: [
                      Flexible(
                        child: MyTextFormField(
                          hintText: 'First Name',
                          isObsecure: false,
                          validator: (value) =>
                              Validator.validateEmptyText('First Name', value),
                          controller: cubit.firstNameController,
                          prefixIcon: const Icon(Iconsax.user, size: 18),
                        ),
                      ),
                      const SizedBox(width: AppSizes.sm),
                      Flexible(
                        child: MyTextFormField(
                          hintText: 'Last Name',
                          isObsecure: false,
                          validator: (value) =>
                              Validator.validateEmptyText('Last Name', value),
                          controller: cubit.lastNameController,
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
                    controller: cubit.usernameController,
                    validator: (value) =>
                        Validator.validateEmptyText('Username', value),
                    prefixIcon: const Icon(Iconsax.user_tag, size: 18),
                  ),
                  const VerticalSpace(height: AppSizes.spaceBtwInputFields),

                  // Email
                  MyTextFormField(
                    hintText: AppTextStrings.tEmail,
                    isObsecure: false,
                    controller: cubit.emailController,
                    validator: (value) => Validator.validateEmail(value),
                    prefixIcon: const Icon(Iconsax.sms, size: 18),
                  ),
                  const VerticalSpace(height: AppSizes.spaceBtwInputFields),
                  // Phone
                  MyTextFormField(
                    hintText: AppTextStrings.tPhoneNo,
                    isObsecure: false,
                    validator: (value) => Validator.validatePhoneNumber(value),
                    controller: cubit.phoneController,
                    prefixIcon: const Icon(Iconsax.call, size: 18),
                  ),
                  const VerticalSpace(height: AppSizes.spaceBtwInputFields),
                  // Password
                  CustomPasswordTextField(
                    passwordEditingController: cubit.passwordController,
                    text: AppTextStrings.password,
                    validator: (value) => Validator.validatePassword(value),
                    prefixIcon: const Icon(Iconsax.password_check, size: 18),
                  ),
                  const VerticalSpace(height: AppSizes.spaceBtwSections / 2),
                  // Agree to privacy policy
                  const AgreePolicyCheckbox(),
                  const VerticalSpace(height: AppSizes.spaceBtwSections),
                  // Create Account button
                  CustomButton(
                    text: 'Create Account',
                    onPressed: () => cubit.signUp(),
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
        ),
      ),
    );
  }
}
