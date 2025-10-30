import 'package:ecommerce_app/core/utils/constant/categories.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/icons/circular_icons.dart';
import 'package:ecommerce_app/core/utils/images/rounded_images.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CircularProductContainerImage extends StatefulWidget {
  const CircularProductContainerImage({super.key, required this.dark});
  final bool dark;

  @override
  State<CircularProductContainerImage> createState() =>
      _CircularProductContainerImageState();
}

class _CircularProductContainerImageState
    extends State<CircularProductContainerImage> {
  int _selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RoundedContainer(
          width: double.infinity,
          height: AppHelperFunctions.screenHeight(context) * 0.44,
          padding: const EdgeInsets.all(AppSizes.sm),

          child: Center(
            child: RoundedImage(
              imageUrl: images[_selectedImage],
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          left: 0,
          
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Iconsax.arrow_left),
          ),
        ),

        const Positioned(
          right: 5,
          top: 8,
          child: CircularIcon(
            icon: Iconsax.heart5,
            size: AppSizes.iconMd,
            color: AppColors.red,
          ),
        ),
        Positioned(
          top: 300,
          left: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(images.length, (i) {
              final selected = i == _selectedImage;
              return Padding(
                padding: const EdgeInsets.only(right: AppSizes.sm),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedImage = i),
                  child: TCircularContainer(
                    width: 64,
                    height: 64,
                    radius: 12,
                    showBorder: selected,
                    borderColor: AppColors.dashboardAppbarBackground,
                    backgroundColor: widget.dark
                        ? AppColors.dark
                        : AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundedImage(
                        imageUrl: images[i],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
