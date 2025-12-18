import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/features/auth/modules/features/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:ecommerce_app/features/auth/modules/features/login/presentation/controller/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomRemeberMeCheckBox extends StatelessWidget {
  const CustomRemeberMeCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.isRememberMe != current.isRememberMe,
      builder: (context, state) {
        return Row(
          children: [
            Checkbox(
              value: state.isRememberMe,
              onChanged: (value) {
                context.read<LoginCubit>().toggleRememberMe();
              },
              activeColor: AppColors.borderPrimary,
              checkColor: AppColors.lightBackground,
            ),
            Text(
              AppTextStrings.rememberMe,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
              },
              child: Text(
                AppTextStrings.tForgetPassword,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.borderPrimary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
