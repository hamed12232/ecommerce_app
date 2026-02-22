import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/icons/favourite_icon.dart';
import 'package:ecommerce_app/core/utils/images/rounded_images.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CircularProductContainerImage extends StatefulWidget {
  const CircularProductContainerImage({
    super.key,
    required this.dark,
    required this.thumbnail,
    required this.productId,
    this.images,
    this.variationImage,
  });

  final String productId;
  final bool dark;
  final String thumbnail;
  final List<String>? images;

  /// When a variation is selected, this overrides the main displayed image
  final String? variationImage;

  @override
  State<CircularProductContainerImage> createState() =>
      _CircularProductContainerImageState();
}

class _CircularProductContainerImageState
    extends State<CircularProductContainerImage> {
  int _selectedImage = 0;

  /// Combines thumbnail + additional images into one list for the gallery
  List<String> get _allImages {
    final list = <String>[widget.thumbnail];
    if (widget.images != null && widget.images!.isNotEmpty) {
      list.addAll(widget.images!);
    }
    return list;
  }

  /// Checks whether the image URL is a network URL (Supabase) or a local asset
  bool _isNetwork(String url) => url.startsWith('http');

  /// The main image to display: variation image overrides the gallery selection
  String get _displayImage {
    if (widget.variationImage != null && widget.variationImage!.isNotEmpty) {
      return widget.variationImage!;
    }
    return _allImages[_selectedImage];
  }

  @override
  Widget build(BuildContext context) {
    final allImages = _allImages;
    final displayImage = _displayImage;

    return Stack(
      children: [
        /// -- Main product image
        RoundedContainer(
          width: double.infinity,
          height: AppHelperFunctions.screenHeight(context) * 0.44,
          padding: const EdgeInsets.all(AppSizes.sm),
          child: Center(
            child: RoundedImage(
              imageUrl: displayImage,
              isNetworkImage: _isNetwork(displayImage),
              fit: BoxFit.contain,
            ),
          ),
        ),

        /// -- Back button
        Positioned(
          left: 0,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Iconsax.arrow_left_2),
          ),
        ),

        /// -- Favourite icon
        Positioned(
          right: 5,
          top: 8,
          child: FavouriteIcon(productId: widget.productId),
        ),

        /// -- Image gallery thumbnails (only show if more than one image)
        if (allImages.length > 1)
          Positioned(
            top: 300,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: List.generate(allImages.length, (i) {
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
                          imageUrl: allImages[i],
                          isNetworkImage: _isNetwork(allImages[i]),
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
