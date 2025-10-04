import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:flutter/material.dart';

class AgreePolicyCheckbox extends StatefulWidget {
  const AgreePolicyCheckbox({super.key});

  @override
  State<AgreePolicyCheckbox> createState() => _AgreePolicyCheckboxState();
}

class _AgreePolicyCheckboxState extends State<AgreePolicyCheckbox> {
  bool agreePolicy = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: agreePolicy,
          onChanged: (v) {
            setState(() {
              agreePolicy = v ?? false;
            });
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
  }
}
