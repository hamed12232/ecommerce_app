import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/widgets/shimmers/shimmer.dart';
import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.overlayColor,
    this.backgroundColor,
    required this.image,
    this.fit = BoxFit.cover,
    this.padding = AppSizes.sm,
    this.isNetworkImage = false,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color:
            backgroundColor ??
            (AppHelperFunctions.isDarkMode(context)
                ? AppColors.black
                : AppColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: image.isEmpty && !isNetworkImage
            ? Icon(
                Icons.image_not_supported_outlined,
                size: width * 0.5,
                color: overlayColor ?? AppColors.darkGrey,
              )
            : isNetworkImage
            ? CachedNetworkImage(
                fit: fit,
                width: width,
                height: height,
                color: overlayColor,
                imageUrl: image,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    ShimmerEffect(width: width, height: height, radius: 100),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )
            : Image(
                fit: fit,
                width: width,
                height: height,
                image: AssetImage(image),
                color: overlayColor,
              ),
      ),
    );
  }
}
