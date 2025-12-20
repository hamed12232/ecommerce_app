import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/validators/validation.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_cubit.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_model_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class UpdateNameScreen extends StatelessWidget {
  const UpdateNameScreen({super.key});

  static const String routeName = '/update-name';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: BlocListener<UserCubit, UserModelState>(
        listenWhen: (previous, current) =>
            previous.successMessage != current.successMessage &&
            current.successMessage != null &&
            current.successMessage!.isNotEmpty,
        listener: (context, state) {
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Headings
              Text(
                'Use real name for easy verification. This name will appear on several pages.',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Form
              Form(
                key: cubit.updateNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: cubit.firstNameController,
                      validator: (value) =>
                          Validator.validateEmptyText('First Name', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: AppTextStrings.firstName,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                    const SizedBox(height: AppSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: cubit.lastNameController,
                      validator: (value) =>
                          Validator.validateEmptyText('Last Name', value),
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: AppTextStrings.lastName,
                        prefixIcon: Icon(Iconsax.user),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Save Button
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<UserCubit, UserModelState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonPrimary,
                      ),
                      onPressed: state.profileLoading
                          ? null
                          : () {
                              if (cubit.updateNameFormKey.currentState!
                                  .validate()) {
                                final user = state.user.copyWith(
                                  firstName: cubit.firstNameController.text
                                      .trim(),
                                  lastName: cubit.lastNameController.text
                                      .trim(),
                                );
                                cubit.updateUserDetails(user);
                              }
                            },
                      child: state.profileLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Save'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
