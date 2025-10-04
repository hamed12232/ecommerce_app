
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomPasswordTextField extends StatefulWidget {
  const CustomPasswordTextField({
    super.key,
    required this.passwordEditingController,
    required this.text, this.validator, this.onChanged, this.prefixIcon,
  });

  final TextEditingController passwordEditingController;
  final String text;
  final String? Function(String? value)? validator;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextFormField(
          controller: widget.passwordEditingController,
          hintText: "*********",
          isObsecure: isObsecure,
          onChanged: widget.onChanged,
          maxLines: 1,
          prefixIcon: widget.prefixIcon,
          
          suffixIcon: IconButton(
            icon: Icon(
              isObsecure ? Iconsax.eye_slash : Iconsax.eye,
              color: AppColors.iconSecondaryDark,
            ),
            onPressed: () {
              setState(() {
                isObsecure = !isObsecure;
              });
            },
          ),
          validator: widget.validator,
          
        ),
      ],
    );
  }
}
