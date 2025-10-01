
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/features/auth/modules/onboarding/model/onboarding_model.dart';
import 'package:ecommerce_app/features/auth/modules/onboarding/presentation/widget/onboarding_widget.dart';
import 'package:flutter/material.dart';

class OnBoardingPageViews extends StatelessWidget {
  const OnBoardingPageViews({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppHelperFunctions.screenHeight(context) * 0.8,
      height: AppHelperFunctions.screenHeight(context) * 0.75,
      padding: EdgeInsets.only(top: 32),
      child: PageView(
        controller: pageController,
        children: [
          OnBoardingPageWidget(
            model: OnBoardingModel(
              image: AppImages.onBoardingImage1,
              title: AppTextStrings.tOnBoardingTitle1,
              subTitle: AppTextStrings.tOnBoardingSubTitle1,
            ),
          ),
          OnBoardingPageWidget(
            model: OnBoardingModel(
              image: AppImages.onBoardingImage2,
              title: AppTextStrings.tOnBoardingTitle2,
              subTitle: AppTextStrings.tOnBoardingSubTitle2,
            ),
          ),
          OnBoardingPageWidget(
            model: OnBoardingModel(
              image: AppImages.onBoardingImage3,
              title: AppTextStrings.tOnBoardingTitle3,
              subTitle: AppTextStrings.tOnBoardingSubTitle3,
            ),
          ),
        ],
      ),
    );
  }
}
