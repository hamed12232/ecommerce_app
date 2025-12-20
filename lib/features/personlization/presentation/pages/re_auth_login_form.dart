import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/validators/validation.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_cubit.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_model_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});
  static const String routeName = 're_auth_login_form';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          cubit.clearReAuthControllers();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Re-Authenticate User')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.defaultSpace),
            child: Form(
              key: cubit.reAuthFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Text
                  const Text(
                    'Please enter your credentials to verify your identity and proceed with account deletion.',
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),

                  /// Email
                  TextFormField(
                    controller: cubit.reAuthEmailController,
                    validator: (value) => Validator.validateEmail(value),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: AppTextStrings.email,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spaceBtwInputFields),

                  /// Password
                  BlocBuilder<UserCubit, UserModelState>(
                    buildWhen: (previous, current) =>
                        previous.hidePassword != current.hidePassword,
                    builder: (context, state) {
                      return TextFormField(
                        controller: cubit.reAuthPasswordController,
                        validator: (value) =>
                            Validator.validateEmptyText('Password', value),
                        obscureText: state.hidePassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Iconsax.password_check),
                          labelText: AppTextStrings.password,
                          suffixIcon: IconButton(
                            onPressed: () => cubit.toggleHidePassword(),
                            icon: Icon(
                              state.hidePassword
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppSizes.spaceBtwSections),

                  /// Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonPrimary,
                      ),
                      onPressed: () {
                        if (cubit.reAuthFormKey.currentState!.validate()) {
                          cubit.reAuthenticateEmailAndPasswordUser(
                            cubit.reAuthEmailController.text.trim(),
                            cubit.reAuthPasswordController.text.trim(),
                          );
                        }
                      },
                      child: const Text('Verify'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
