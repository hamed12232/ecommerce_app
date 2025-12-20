import 'package:ecommerce_app/core/style/spacing/horizental_space.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/images/circular_image.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_cubit.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_model_state.dart';
import 'package:ecommerce_app/features/personlization/presentation/pages/profile_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class TopAccountProfileScetion extends StatelessWidget {
  const TopAccountProfileScetion({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModelState>(
      builder: (context, state) {
        final user = state.user;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppTextStrings.account,
              style: Theme.of(
                context,
              ).textTheme.displayMedium!.copyWith(color: AppColors.textWhite),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const VerticalSpace(height: AppSizes.spaceBtwSections),
            Row(
              children: [
                CircularImage(
                  isNetworkImage: user.profileImage.isNotEmpty,
                  image: user.profileImage.isNotEmpty
                      ? user.profileImage
                      : AppImages.userProfileImage,
                  fit: BoxFit.cover,
                  padding: 0,
                ),
                const HorizentalSpace(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.firstName.isNotEmpty
                            ? "${user.firstName} ${user.lastName}"
                            : AppTextStrings.tProfileHeading,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: AppColors.textWhite),
                      ),
                      const VerticalSpace(height: AppSizes.xs),
                      Text(
                        user.email.isNotEmpty
                            ? user.email
                            : AppTextStrings.tProfileSubHeading,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textWhite.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),

                // Edit icon
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ProfileInfoScreen.routeName);
                  },
                  icon: const Icon(Iconsax.edit, color: Colors.white),
                ),
              ],
            ),
            const VerticalSpace(height: AppSizes.spaceBtwInputFields),
          ],
        );
      },
    );
  }
}
