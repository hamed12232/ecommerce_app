import 'package:ecommerce_app/core/style/spacing/horizental_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/controller/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSignInMethodsButtons extends StatelessWidget {
  const CustomSignInMethodsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => context.read<LoginCubit>().loginWithGoogle(),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(14),
            side: const BorderSide(color: AppColors.grey),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          child: Image.asset(AppImages.googleLogo, height: AppSizes.iconMd),
        ),
        const HorizentalSpace(width: AppSizes.spaceBtwInputFields),
        // Facebook
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(14),
            elevation: 0,
            backgroundColor: Colors.transparent,
            side: const BorderSide(color: AppColors.grey),
          ),
          child: Image.asset(AppImages.facebookLogo, height: 24),
        ),
      ],
    );
  }
}
