import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_app/features/personlization/data/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.address, this.onTap});

  final AddressModel address;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(AppSizes.md),
        width: double.infinity,
        backgroundColor: address.selectedAddress
            ? AppColors.dashboardAppbarBackground.withValues(alpha: 0.5)
            : Colors.transparent,
        borderColor: address.selectedAddress
            ? Colors.transparent
            : dark
            ? AppColors.darkerGrey
            : AppColors.grey,
        margin: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
        child: Stack(
          children: [
            Positioned(
              right: 5,
              top: 0,
              child: Icon(
                address.selectedAddress ? Iconsax.tick_circle5 : null,
                color: address.selectedAddress
                    ? dark
                          ? AppColors.lightBackground
                          : AppColors.dark
                    : null,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSizes.sm / 2),
                Text(
                  address.phoneNumber,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSizes.sm / 2),
                Text(address.street.toString(), softWrap: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
