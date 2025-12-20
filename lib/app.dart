import 'package:ecommerce_app/core/di/service_locator.dart';
import 'package:ecommerce_app/core/routes/navigation_routes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/services/shared_pref.dart';
import 'package:ecommerce_app/core/utils/theme/theme.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/controller/cubit/login_cubit.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/screen/login_screen.dart';
import 'package:ecommerce_app/features/auth/modules/features/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:ecommerce_app/features/auth/modules/features/verify_email/presentation/controller/cubit/verify_email_cubit.dart';
import 'package:ecommerce_app/features/auth/modules/features/verify_email/presentation/pages/verify_email_screen.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/settings_cubit.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/user_cubit.dart';
import 'package:ecommerce_app/navigation_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SettingsCubit>()),
        BlocProvider(
          create: (context) => getIt<UserCubit>()..fetchUserRecord(),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: NavigationRoutes.generateRoute,
        home: _screenRedirect(FirebaseAuth.instance.currentUser),
      ),
    );
  }

  Widget _screenRedirect(User? user) {
    if (user != null) {
      if (user.emailVerified) {
        return const NavigationMenu();
      } else {
        return BlocProvider(
          create: (context) => getIt<VerifyEmailCubit>()
            ..sendEmailVerification()
            ..setTimerForAutoRedirect(),
          child: VerifyEmailScreen(
            email: user.email ?? '',
            title: AppTextStrings.confirmEmail,
            subtitle: AppTextStrings.confirmEmailSubTitle,
            buttonTitle: AppTextStrings.tContinue,
          ),
        );
      }
    } else {
      if (SharedPrefServices.isFirstTime()) {
        return const OnboardingScreen();
      } else {
        return BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const LoginScreen(),
        );
      }
    }
  }
}
