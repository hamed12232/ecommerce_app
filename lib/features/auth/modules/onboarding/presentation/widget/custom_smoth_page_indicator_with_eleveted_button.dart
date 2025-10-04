import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/features/auth/modules/login/presentation/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmothPageIndicatorWithElevetedButton extends StatelessWidget {
  const CustomSmothPageIndicatorWithElevetedButton({
    super.key,
    required this.pageController,
    required this.isdark,
  });

  final PageController pageController;
  final bool isdark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
      child: Row(
        children: [
          SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: ExpandingDotsEffect(
              activeDotColor: isdark ? AppColors.lightGrey : AppColors.dark,
              dotHeight: 6,
            ),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16),
              elevation: 0,
              iconSize: AppSizes.iconMd,
            ),
            onPressed: () {
              if (pageController.page == 2) {
                AppHelperFunctions.navigateToScreen(
                  context,
                  const LoginScreen(),
                );
              } else {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              }
            },
            child: const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.lightGrey,
            ),
          ),
        ],
      ),
    );
  }
}
