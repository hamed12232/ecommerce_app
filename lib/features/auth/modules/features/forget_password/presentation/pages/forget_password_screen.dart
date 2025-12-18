import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/style/spacing_style.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_app/core/utils/popups/loaders.dart';
import 'package:ecommerce_app/core/utils/validators/validation.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/features/auth/modules/features/forget_password/presentation/controller/cubit/forget_password_cubit.dart';
import 'package:ecommerce_app/features/auth/modules/features/forget_password/presentation/controller/cubit/forget_password_state.dart';
import 'package:ecommerce_app/features/auth/modules/features/forget_password/presentation/pages/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  static const String routeName = '/forget-password';

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state.status == ForgetPasswordStatus.loading) {
          AppFullScreenLoader.openLoadingDialog(
            'The email is being sent...',
            AppImages.docerAnimation,
            context,
          );
        } else if (state.status == ForgetPasswordStatus.success) {
          AppFullScreenLoader.stopLoading(context);
          AppLoaders.successSnackBar(
            title: 'Success',
            message: 'Check your email for a verification link',
            context: context,
          );
          Navigator.pushNamed(
            context,
            ResetPasswordScreen.routeName,
            arguments: {'email': emailController.text.trim()},
          );
        } else if (state.status == ForgetPasswordStatus.error) {
          AppFullScreenLoader.stopLoading(context);
          AppLoaders.errorSnackBar(
            title: 'Error',
            message: state.error ?? 'Something went wrong',
            context: context,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: SpacingStyle.defaultPadding,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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

                    Form(
                      key: formKey,
                      child: MyTextFormField(
                        hintText: AppTextStrings.tEmail,
                        isObsecure: false,
                        controller: emailController,
                        prefixIcon: const Icon(Iconsax.direct_right, size: 18),
                        validator: (value) => Validator.validateEmail(value),
                      ),
                    ),
                    const VerticalSpace(height: AppSizes.spaceBtwSections),

                    CustomButton(
                      text: 'Submit',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context
                              .read<ForgetPasswordCubit>()
                              .sendPasswordResetEmail(
                                emailController.text.trim(),
                              );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
