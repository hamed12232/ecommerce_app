import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SingleAddress extends StatefulWidget {
  const SingleAddress({super.key, required this.address});

  final String address;

  @override
  State<SingleAddress> createState() => _SingleAddressState();
}

class _SingleAddressState extends State<SingleAddress> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: RoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(AppSizes.md),
        width: double.infinity,
        backgroundColor: isSelected
            ? AppColors.dashboardAppbarBackground.withValues(alpha: 0.5)
            : Colors.transparent,
        borderColor: isSelected
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
                isSelected ? Iconsax.tick_circle5 : null,
                color: isSelected
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
                  widget.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSizes.sm / 2),
                Text(
                  widget.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSizes.sm / 2),
                Text(widget.address.toString(), softWrap: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
