import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/images/circular_image.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_cubit.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_model_state.dart';
import 'package:ecommerce_app/features/personlization/presentation/widget/info_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({super.key});

  static const String routeName = '/profile-info';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppTextStrings.tProfile,
          style: theme.textTheme.headlineMedium?.copyWith(),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: BlocBuilder<UserCubit, UserModelState>(
        builder: (context, state) {
          final user = state.user;
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.defaultSpace,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const VerticalSpace(height: 12),
                Center(
                  child: Column(
                    children: [
                      CircularImage(
                        isNetworkImage: user.profileImage.isNotEmpty,
                        image: user.profileImage.isNotEmpty
                            ? user.profileImage
                            : AppImages.userProfileImage,
                        backgroundColor: AppColors.grey,
                      ),
                      const VerticalSpace(height: AppSizes.lg),
                      Text(
                        AppTextStrings.tChangeProfilePicture,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const VerticalSpace(height: 18),
                const Divider(),
                const VerticalSpace(height: 12),

                const SectionHeading(
                  title: AppTextStrings.tProfileInformation,
                  showActionButton: false,
                ),
                const VerticalSpace(height: AppSizes.sm),
                InfoRow(
                  label: AppTextStrings.lblName,
                  value: user.firstName.isNotEmpty
                      ? "${user.firstName} ${user.lastName}"
                      : 'N/A',
                  onTap: () {},
                ),
                InfoRow(
                  label: AppTextStrings.lblUsername,
                  value: user.username.isNotEmpty ? user.username : 'N/A',
                  onTap: () {},
                ),

                const VerticalSpace(height: 12),
                const Divider(),
                const VerticalSpace(height: 12),

                const SectionHeading(
                  title: AppTextStrings.tPersonalInformation,
                  showActionButton: false,
                ),
                const VerticalSpace(height: AppSizes.sm),
                InfoRow(
                  label: AppTextStrings.lblUserId,
                  value: user.id.isNotEmpty ? user.id : 'N/A',
                  trailing: IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {},
                  ),
                ),
                InfoRow(
                  label: AppTextStrings.lblEmail,
                  value: user.email.isNotEmpty ? user.email : 'N/A',
                  onTap: () {},
                ),
                InfoRow(
                  label: AppTextStrings.lblPhoneNumber,
                  value: user.phone.isNotEmpty ? user.phone : 'N/A',
                  onTap: () {},
                ),
                InfoRow(
                  label: AppTextStrings.lblGender,
                  value: 'Male', // TODO: Add gender to UserModel if needed
                  onTap: () {},
                ),
                InfoRow(
                  label: AppTextStrings.lblDateOfBirth,
                  value: '10 Oct, 1994', // TODO: Add DOB to UserModel if needed
                  onTap: () {},
                ),

                const VerticalSpace(height: 18),
                const Divider(),
                const VerticalSpace(height: 24),

                Center(
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement Close Account navigation or dialog
                    },
                    child: Text(
                      AppTextStrings.tCloseAccount,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
