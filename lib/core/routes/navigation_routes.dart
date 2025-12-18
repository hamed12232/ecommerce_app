import 'package:ecommerce_app/core/di/service_locator.dart';
import 'package:ecommerce_app/features/auth/modules/features/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/controller/cubit/login_cubit.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/screen/login_screen.dart';
import 'package:ecommerce_app/features/auth/modules/features/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:ecommerce_app/features/auth/modules/features/signUp/presentation/controller/cubit/sign_up_cubit.dart';
import 'package:ecommerce_app/features/auth/modules/features/signUp/presentation/pages/sign_up_screen.dart';
import 'package:ecommerce_app/features/auth/modules/features/success/presentation/pages/success_screen.dart';
import 'package:ecommerce_app/features/auth/modules/features/verify_email/presentation/controller/cubit/verify_email_cubit.dart';
import 'package:ecommerce_app/features/auth/modules/features/verify_email/presentation/pages/verify_email_screen.dart';
import 'package:ecommerce_app/features/personlization/presentation/pages/profile_info_screen.dart';
import 'package:ecommerce_app/features/personlization/presentation/pages/profile_screen.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/presentation/page/all_product_screen.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/pages/cart_screen.dart';
import 'package:ecommerce_app/features/shop/modules/checkout/presentation/pages/checkout_screen.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/pages/home_screen.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/screen/store_screen.dart';
import 'package:ecommerce_app/features/shop/modules/wishlist/presentation/pages/wishlist_screen.dart';
import 'package:ecommerce_app/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ========== Auth Routes ==========
      case OnboardingScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );

      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );

      case SignUpScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<SignUpCubit>(),
            child: const SignUpScreen(),
          ),
        );

      case ForgetPasswordScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen(),
        );

      case VerifyEmailScreen.routeName:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<VerifyEmailCubit>()
              ..sendEmailVerification()
              ..setTimerForAutoRedirect(),
            child: VerifyEmailScreen(
              email: args?['email'] ?? '',
              title: args?['title'] ?? '',
              subtitle: args?['subtitle'] ?? '',
              buttonTitle: args?['buttonTitle'] ?? '',
              isForgetPasswordScreen: args?['isForgetPasswordScreen'] ?? false,
            ),
          ),
        );

      case SuccessScreen.routeName:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => SuccessScreen(
            image: args?['image'] ?? '',
            onPressed: args?['onPressed'] ?? () {},
          ),
        );

      // ========== Main Navigation ==========
      case NavigationMenu.routeName:
        return MaterialPageRoute(builder: (context) => const NavigationMenu());

      // ========== Shop Routes ==========
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case StoreScreen.routeName:
        return MaterialPageRoute(builder: (context) => const StoreScreen());

      case WishlistScreen.routeName:
        return MaterialPageRoute(builder: (context) => const WishlistScreen());

      case CartScreen.routeName:
        return MaterialPageRoute(builder: (context) => const CartScreen());

      case CheckoutScreen.routeName:
        return MaterialPageRoute(builder: (context) => const CheckoutScreen());

      case AllProductScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const AllProductScreen(),
        );

      // ========== Personalization Routes ==========
      case ProfileScreen.routeName:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());

      case ProfileInfoScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ProfileInfoScreen(),
        );

      // ========== Default Route ==========
      default:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
    }
  }
}
