import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/screen/login_screen.dart';
import 'package:ecommerce_app/features/auth/modules/features/onboarding/presentation/widget/custom_smoth_page_indicator_with_eleveted_button.dart';
import 'package:ecommerce_app/features/auth/modules/features/onboarding/presentation/widget/on_boarding_page_view.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final isdark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              AppHelperFunctions.navigateToScreen(context, const LoginScreen());
            },
            child: Text(
              AppTextStrings.skip,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          OnBoardingPageViews(pageController: pageController),
          const SizedBox(height: 20.0),
          CustomSmothPageIndicatorWithElevetedButton(
            pageController: pageController,
            isdark: isdark,
          ),
        ],
      ),
    );
  }
}
