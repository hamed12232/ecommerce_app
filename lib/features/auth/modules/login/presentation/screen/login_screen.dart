import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/style/spacing_style.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/core/widgets/custom_password_text_field.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/features/auth/modules/features/signUp/presentation/pages/sign_up_screen.dart';
import 'package:ecommerce_app/features/auth/modules/login/presentation/widgets/custom_divider_sign_in_methods.dart';
import 'package:ecommerce_app/features/auth/modules/login/presentation/widgets/custom_remeber_me_check_box.dart';
import 'package:ecommerce_app/features/auth/modules/login/presentation/widgets/custom_sign_in_methods_buttons.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    final isdark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: SpacingStyle.defaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  isdark ? AppImages.logoImageLight : AppImages.logoImagedark,
                  height: AppHelperFunctions.screenHeight(context) * 0.3,
                  width: AppHelperFunctions.screenWidth(context) * 0.5,
                ),
              ),
              Text(
                AppTextStrings.tLoginTitle,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const VerticalSpace(height: AppSizes.sm),
              Text(
                AppTextStrings.tLoginSubTitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const VerticalSpace(height: AppSizes.spaceBtwSections),
              MyTextFormField(
                hintText: AppTextStrings.email,
                isObsecure: false,
                controller: emailEditingController,
                prefixIcon: const Icon(Iconsax.direct_right),
              ),
              const VerticalSpace(height: AppSizes.spaceBtwInputFields),
              CustomPasswordTextField(
                text: AppTextStrings.password,
                passwordEditingController: passwordEditingController,
                prefixIcon: const Icon(Iconsax.password_check),
              ),
              const VerticalSpace(height: AppSizes.spaceBtwSections / 2),
              const CustomRemeberMeCheckBox(),
              const VerticalSpace(height: AppSizes.spaceBtwSections),
              CustomButton(text: AppTextStrings.tLogin, onPressed: () {}),
              const VerticalSpace(height: AppSizes.spaceBtwSections / 2),
              CustomButton(
                text: AppTextStrings.tSignup,
                onPressed: () {
                  AppHelperFunctions.navigateToScreen(context, const SignUpScreen());
                },
                buttonColor: Colors.transparent,
                hasBorderColor: true,
              ),
              const VerticalSpace(height: AppSizes.spaceBtwSections),
              const CustomDividerSignInMethods(),
              const VerticalSpace(height: AppSizes.spaceBtwSections),
              const CustomSignInMethodsButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
