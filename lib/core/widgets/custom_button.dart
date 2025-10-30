
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.text,

    this.fontSize = 16,
    this.buttonColor = AppColors.primary,
    
    this.isButtonImageSelector = false, this.borderRadius,  this.hasBorderColor=false,
  });
  final void Function()? onPressed;
  final String text;
  final double fontSize;
  final Color buttonColor;
  final bool isButtonImageSelector;
  final bool hasBorderColor;
  final BorderRadiusGeometry? borderRadius;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(AppSizes.borderRadiusLg)),
        side:  BorderSide(color: hasBorderColor ? AppColors.grey : Colors.transparent, width: 1),
        minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
        ),
      child: Text(
        text,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: fontSize,color: AppHelperFunctions.isDarkMode(context) ? AppColors.textWhite : AppColors.darkBackground),
      ),
    );
  }
}
