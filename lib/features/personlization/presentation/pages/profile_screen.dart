import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_app/features/personlization/presentation/widget/main_profile_section.dart';
import 'package:ecommerce_app/features/personlization/presentation/widget/top_account_category.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
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
    );
  }
}
