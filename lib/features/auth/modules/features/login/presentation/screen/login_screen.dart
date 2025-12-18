import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/style/spacing_style.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_app/core/utils/popups/loaders.dart';
import 'package:ecommerce_app/core/utils/validators/validation.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/controller/cubit/login_cubit.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/widgets/custom_divider_sign_in_methods.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/widgets/custom_remeber_me_check_box.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/widgets/custom_sign_in_methods_buttons.dart';
import 'package:ecommerce_app/features/auth/modules/features/signUp/presentation/pages/sign_up_screen.dart';
import 'package:ecommerce_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    final isdark = AppHelperFunctions.isDarkMode(context);
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          AppFullScreenLoader.stopLoading(context);
          AppLoaders.successSnackBar(
            title: 'Success',
            message: 'Login Success',
            context: context,
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            NavigationMenu.routeName,
            (route) => false,
          );
        } else if (state.status == LoginStatus.loading) {
          AppFullScreenLoader.openLoadingDialog(
            'Logging you in ......',
            AppImages.docerAnimation,
            context,
          );
        } else if (state.status == LoginStatus.error) {
          AppFullScreenLoader.stopLoading(context);
          AppLoaders.errorSnackBar(
            title: 'Oh Snap!',
            message: state.error ?? 'Something went wrong',
            context: context,
          );
        }
      },
      child: Scaffold(
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
                Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      MyTextFormField(
                        hintText: AppTextStrings.email,
                        isObsecure: false,
                        controller: cubit.emailController,
                        prefixIcon: const Icon(Iconsax.direct_right),
                        validator: (value) => Validator.validateEmail(value),
                      ),
                      const VerticalSpace(height: AppSizes.spaceBtwInputFields),
                      BlocBuilder<LoginCubit, LoginState>(
                        buildWhen: (previous, current) =>
                            previous.isPasswordVisible !=
                            current.isPasswordVisible,
                        builder: (context, state) {
                          return MyTextFormField(
                            hintText: AppTextStrings.password,
                            isObsecure: state.isPasswordVisible,
                            controller: cubit.passwordController,
                            maxLines: 1,
                            prefixIcon: const Icon(Iconsax.password_check),
                            suffixIcon: IconButton(
                              onPressed: cubit.togglePasswordVisibility,
                              icon: Icon(
                                state.isPasswordVisible
                                    ? Iconsax.eye_slash
                                    : Iconsax.eye,
                                color: AppColors.iconSecondaryDark,
                              ),
                            ),
                            validator: (value) =>
                                Validator.validateEmptyText('Password', value),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const VerticalSpace(height: AppSizes.spaceBtwSections / 2),
                const CustomRemeberMeCheckBox(),
                const VerticalSpace(height: AppSizes.spaceBtwSections),
                CustomButton(
                  text: AppTextStrings.tLogin,
                  onPressed: () {
                    cubit.login();
                  },
                ),
                const VerticalSpace(height: AppSizes.spaceBtwSections / 2),
                CustomButton(
                  text: AppTextStrings.tSignup,
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpScreen.routeName);
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
      ),
    );
  }
}
