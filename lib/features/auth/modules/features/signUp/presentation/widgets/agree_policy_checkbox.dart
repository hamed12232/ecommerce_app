import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/features/auth/modules/features/signUp/presentation/controller/cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgreePolicyCheckbox extends StatelessWidget {
  const AgreePolicyCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Row(
          children: [
            Checkbox(
              value: state.agreePolicy,
              onChanged: (v) {
                context.read<SignUpCubit>().toggleAgreePolicy(v ?? false);
              },
              activeColor: AppColors.borderPrimary,
              checkColor: AppColors.lightBackground,
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: const [
                    TextSpan(text: 'I agree to '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Terms of use',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
