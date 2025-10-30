import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/categories.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';

class SizeSelectionWidget extends StatefulWidget {
  const SizeSelectionWidget({
    super.key,
    required this.theme,
    required this.dark,
  });
  final ThemeData theme;
  final bool dark;

  @override
  State<SizeSelectionWidget> createState() => _SizeSelectionWidgetState();
}

class _SizeSelectionWidgetState extends State<SizeSelectionWidget> {
  int _selectedSize = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Size', style: widget.theme.textTheme.titleLarge),
        const VerticalSpace(height: AppSizes.sm),
        Row(
          children: List.generate(sizes.length, (i) {
            final sel = i == _selectedSize;
            return GestureDetector(
              onTap: () => setState(() => _selectedSize = i),
              child: Padding(
                padding: const EdgeInsets.only(right: AppSizes.sm),
                child: RoundedContainer(
                  width: 90,
                  height: 50,
                  showBorder: !sel,
                  borderColor: AppColors.darkGrey,
                  radius: AppSizes.cardRadiusMd,
                  backgroundColor: sel
                      ? AppColors.dashboardAppbarBackground
                      : (widget.dark
                            ? AppColors.dark
                            : AppColors.white),
                  child: Row(
                    mainAxisAlignment:sel? MainAxisAlignment.spaceBetween: MainAxisAlignment.center,
                    children: [
                      if (sel)
                        const Icon(
                          Icons.check,
                          size: AppSizes.iconSm,
                          color: AppColors.white,
                        ),
                      Center(
                        child: Text(
                          sizes[i],
                          style: widget.theme.textTheme.labelLarge?.copyWith(
                            color: sel ? AppColors.white : null,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
