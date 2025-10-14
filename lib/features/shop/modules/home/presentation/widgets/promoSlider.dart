import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/images/rounded_images.dart';
import 'package:flutter/material.dart';

class PromoSlider extends StatefulWidget {
  const PromoSlider({super.key});

  @override
  State<PromoSlider> createState() => _PromosliderState();
}

class _PromosliderState extends State<PromoSlider> {
  double currentIndex = 0;
  CarouselSliderController carouselController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: CarouselSlider(
            carouselController: carouselController,

            options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index.toDouble();
                });
              },
              initialPage: 0,
              enlargeCenterPage: true,
            ),
            items: const [
              RoundedImage(imageUrl: AppImages.promoBanner1),
              RoundedImage(imageUrl: AppImages.promoBanner2),
              RoundedImage(imageUrl: AppImages.promoBanner3),
            ],
          ),
        ),
        const VerticalSpace(height: AppSizes.spaceBtwItems),
        DotsIndicator(
          dotsCount: 3,
          position: currentIndex,
          decorator: DotsDecorator(
            size: const Size(20.0, 4.0),
            activeSize: const Size(20.0, 4.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            activeColor: AppColors.primary,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
