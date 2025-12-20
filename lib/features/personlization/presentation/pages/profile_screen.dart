import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/popups/loaders.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/screen/login_screen.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/settings_cubit.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_cubit.dart';
import 'package:ecommerce_app/features/personlization/presentation/widget/main_profile_section.dart';
import 'package:ecommerce_app/features/personlization/presentation/widget/top_account_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state.status == SettingsStatus.success) {
          context.read<UserCubit>().clearUserData();
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginScreen.routeName,
            (route) => false,
          );
        } else if (state.status == SettingsStatus.error) {
          AppLoaders.errorSnackBar(
            title: 'Error',
            message: state.error ?? 'Something went wrong',
            context: context,
          );
        }
      },
      child: Scaffold(
        backgroundColor: isDark ? AppColors.dark : AppColors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header with curved background
              TPrimaryHeaderContainer(
                child: RoundedContainer(
                  padding: EdgeInsets.only(
                    top: AppHelperFunctions.getTopSafeArea(context) + 12,
                    left: 18,
                    right: 18,
                    bottom: 18,
                  ),
                  child: const TopAccountProfileScetion(),
                ),
              ),

              // Main content container (rounded top)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.defaultSpace,
                  vertical: AppSizes.lg,
                ),
                child: MainProfileSection(isDark: isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
