import 'package:ecommerce_app/core/di/service_locator.dart';
import 'package:ecommerce_app/features/auth/modules/features/forget_password/presentation/controller/cubit/forget_password_cubit.dart';
import 'package:ecommerce_app/features/auth/modules/features/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:ecommerce_app/features/auth/modules/features/forget_password/presentation/pages/reset_password_screen.dart';
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
import 'package:ecommerce_app/features/personlization/presentation/pages/re_auth_login_form.dart';
import 'package:ecommerce_app/features/personlization/presentation/pages/update_name_screen.dart';
import 'package:ecommerce_app/features/personlization/presentation/pages/user_address.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/presentation/cubit/all_products_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/presentation/page/all_product_screen.dart';
import 'package:ecommerce_app/features/shop/modules/brand/domain/entities/brand_entity.dart';
import 'package:ecommerce_app/features/shop/modules/brand/presentation/controller/cubit/brand_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/brand/presentation/page/all_brands.dart';
import 'package:ecommerce_app/features/shop/modules/brand/presentation/page/brand_product.dart';
import 'package:ecommerce_app/features/shop/modules/cart/presentation/pages/cart_screen.dart';
import 'package:ecommerce_app/features/shop/modules/checkout/presentation/pages/checkout_screen.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/pages/home_screen.dart';
import 'package:ecommerce_app/features/shop/modules/order/presentation/page/my_order_screen.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_model.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/product_details.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/screen/store_screen.dart';
import 'package:ecommerce_app/features/shop/modules/subCategory/presentation/page/sub_category.dart';
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
          builder: (context) => BlocProvider(
            create: (context) => getIt<ForgetPasswordCubit>(),
            child: const ForgetPasswordScreen(),
          ),
        );

      case ResetPasswordScreen.routeName:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ForgetPasswordCubit>(),
            child: ResetPasswordScreen(email: args?['email'] ?? ''),
          ),
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

      case SubCategory.routeName:
        return MaterialPageRoute(builder: (context) => const SubCategory());

      case AllBrands.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<BrandCubit>()..fetchBrands(),
            child: const AllBrands(),
          ),
        );

      case BrandProduct.routeName:
        final brand = settings.arguments as BrandEntity;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt<BrandCubit>()..fetchBrandProducts(brand.id),
            child: BrandProduct(brand: brand),
          ),
        );

      case AllProductScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                getIt<AllProductsCubit>()..getAllFeaturedProducts(),
            child: const AllProductScreen(),
          ),
        );

      case ProductDetails.routeName:
        final args = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (context) => ProductDetails(product: args),
        );

      // ========== Personalization Routes ==========
      case ProfileScreen.routeName:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());

      case ProfileInfoScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ProfileInfoScreen(),
        );

      case MyOrdersScreen.routeName:
        return MaterialPageRoute(builder: (context) => const MyOrdersScreen());

      case UserAddress.routeName:
        return MaterialPageRoute(builder: (context) => const UserAddress());

      case ReAuthLoginForm.routeName:
        return MaterialPageRoute(builder: (context) => const ReAuthLoginForm());

      case UpdateNameScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const UpdateNameScreen(),
        );

      // ========== Default Route ==========
      default:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
    }
  }
}
