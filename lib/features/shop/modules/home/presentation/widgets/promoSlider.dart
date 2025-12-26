import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/images/rounded_images.dart';
import 'package:ecommerce_app/core/widgets/shimmers/shimmer.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/controller/cubit/banner_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/controller/cubit/banner_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromoSlider extends StatefulWidget {
  const PromoSlider({super.key});

  @override
  State<PromoSlider> createState() => _PromosliderState();
}

class _PromosliderState extends State<PromoSlider> {
  double currentIndex = 0;
  CarouselSliderController carouselController = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    context.read<BannerCubit>().fetchBanners();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerCubit, BannerState>(
      builder: (context, state) {
        if (state.status == BannerStatus.loading) {
          return const Padding(
            padding: EdgeInsets.all(AppSizes.defaultSpace),
            child: ShimmerEffect(
              width: double.infinity,
              height: 158,
              radius: AppSizes.md,
            ),
          );
        }

        if (state.status == BannerStatus.error && state.banners.isEmpty) {
          return Center(child: Text(state.error));
        }

        final banners = state.banners;

        return Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: AppSizes.defaultSpace,
            //   ),
            //   child: SectionHeading(
            //     title: 'Banners',
            //     showActionButton: true,
            //     buttonTitle: 'Upload',
            //     onPressed: () => context.read<BannerCubit>().uploadDummyData(
            //       TDummyData.banners,
            //     ),
            //   ),
            // ),
            const VerticalSpace(height: AppSizes.spaceBtwItems),
            if (banners.isNotEmpty)
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
                  items: banners
                      .map(
                        (banner) => RoundedImage(
                          onPressed: () => Navigator.pushNamed(context, banner.targetScreen),
                          imageUrl: banner.imageUrl,
                          isNetworkImage: true,
                        ),
                      )
                      .toList(),
                ),
              ),
            if (banners.isNotEmpty)
              const VerticalSpace(height: AppSizes.spaceBtwItems),
            if (banners.isNotEmpty)
              DotsIndicator(
                dotsCount: banners.length,
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
      },
    );
  }
}
