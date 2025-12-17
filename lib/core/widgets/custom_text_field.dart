
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.hintText,
    this.suffixIcon,
    required this.isObsecure,
    required this.controller,
    this.validator,
    this.onTap,
    this.onChanged,
    this.maxLines, this.prefixIcon,
  });
  final String hintText;
  final bool isObsecure;
  final String? Function(String? value)? validator;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHelperFunctions.screenHeight(context)*0.065,
      width: AppHelperFunctions.screenWidth(context)*0.9,
      child: TextFormField(
         style: Theme.of( context).inputDecorationTheme.hintStyle,
        obscureText: isObsecure,
        obscuringCharacter: '*',
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        controller: controller,
        maxLines: maxLines,
        
        

        autofocus: false,
        onTap: onTap,
        onChanged: onChanged,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          hintText: hintText,
          isDense: true,
          hintStyle: Theme.of(context).textTheme.bodyLarge,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          prefixIconColor: AppColors.iconSecondaryDark,
          filled: true,
          fillColor: AppHelperFunctions.isDarkMode(context) 
              ? AppColors.dark
              : AppColors.lightBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            borderSide: const BorderSide(
              color: AppColors.grey,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            borderSide: const BorderSide(
              color: AppColors.grey,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            borderSide: const BorderSide(
              color: AppColors.borderPrimary,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
            borderSide: const BorderSide(
              color: AppColors.red,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
            borderSide: const BorderSide(
              color: AppColors.red,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
