import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/dialog/show_dialog.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/features/personlization/presentation/pages/user_address.dart';
import 'package:ecommerce_app/features/personlization/presentation/widget/account_menu_item.dart';
import 'package:ecommerce_app/features/personlization/presentation/widget/account_setting_toggle.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MainProfileSection extends StatelessWidget {
  const MainProfileSection({super.key, required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(
          title: AppTextStrings.tAccountSettings,
          showActionButton: false,
        ),
        const VerticalSpace(height: AppSizes.md),

        AccountMenuItem(
          icon: Iconsax.location,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserAddress()),
          ),
          title: AppTextStrings.tMyAddresses,
          subtitle: AppTextStrings.tMyAddressesSubtitle,
          isDark: isDark,
        ),
        AccountMenuItem(
          icon: Iconsax.card,
          title: AppTextStrings.tMyCart,
          subtitle: AppTextStrings.tMyCartSubtitle,
          isDark: isDark,
        ),
        AccountMenuItem(
          icon: Iconsax.box,
          title: AppTextStrings.tMyOrders,
          subtitle: AppTextStrings.tMyOrdersSubtitle,
          isDark: isDark,
        ),
        AccountMenuItem(
          icon: Iconsax.bank,
          title: AppTextStrings.tBankAccount,
          subtitle: AppTextStrings.tBankAccountSubtitle,
          isDark: isDark,
        ),
        AccountMenuItem(
          icon: Iconsax.discount_circle,
          title: AppTextStrings.tMyCoupons,
          subtitle: AppTextStrings.tMyCouponsSubtitle,
          isDark: isDark,
        ),
        AccountMenuItem(
          icon: Iconsax.notification,
          title: AppTextStrings.tNotifications,
          subtitle: AppTextStrings.tNotificationsSubtitle,
          isDark: isDark,
        ),
        AccountMenuItem(
          icon: Iconsax.lock,
          title: AppTextStrings.tAccountPrivacy,
          subtitle: AppTextStrings.tAccountPrivacySubtitle,
          isDark: isDark,
        ),

        const VerticalSpace(height: AppSizes.lg),
        const SectionHeading(title: 'App Settings', showActionButton: false),
        const VerticalSpace(height: AppSizes.md),

        // App Settings toggles (matching screenshot)
        AccountSettingToggle(
          icon: Iconsax.save_2,
          title: AppTextStrings.tLoadData,
          hasToggle: false,
          subtitle: AppTextStrings.tLoadDataSubtitle,
          isDark: isDark,
        ),

        AccountSettingToggle(
          icon: Iconsax.location,
          isDark: isDark,

          title: AppTextStrings.tGeolocation,
          subtitle: AppTextStrings.tGeolocationSubtitle,
        ),

        AccountSettingToggle(
          icon: Iconsax.security,
          isDark: isDark,

          title: AppTextStrings.tSafeMode,
          subtitle: AppTextStrings.tSafeModeSubtitle,
        ),

        AccountSettingToggle(
          icon: Iconsax.image,
          title: AppTextStrings.tHdImageQuality,
          isDark: isDark,

          subtitle: AppTextStrings.tHdImageQualitySubtitle,
        ),

        const SizedBox(height: 24),

        // Logout button
        CustomButton(
          text: AppTextStrings.tLogout,
          onPressed: () => ShowDialog.showLogoutModal(context),
        ),

        const SizedBox(height: 40),
      ],
    );
  }
}
