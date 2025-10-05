import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/features/auth/modules/features/forget_password/presentation/pages/forget_password_screen.dart';
import 'package:flutter/material.dart';

class CustomRemeberMeCheckBox extends StatefulWidget {
  const CustomRemeberMeCheckBox({super.key});

  @override
  State<CustomRemeberMeCheckBox> createState() => _CustomRemeberMeCheckBoxState();
}

class _CustomRemeberMeCheckBoxState extends State<CustomRemeberMeCheckBox> {
    bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isRememberMe,
          onChanged: (value) {
            setState(() {
              isRememberMe = value!;
            });
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
            AppHelperFunctions.navigateToScreen(context, const ForgetPasswordScreen());
          },
          child: Text(
            AppTextStrings.tForgetPassword,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: AppColors.borderPrimary),
          ),
        ),
      ],
    );
  }
}
