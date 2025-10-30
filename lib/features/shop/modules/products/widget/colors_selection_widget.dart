import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/categories.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:flutter/material.dart';

class ColorsSelectionWidget extends StatefulWidget {
  const ColorsSelectionWidget({super.key, required this.theme});
  final ThemeData theme;

  @override
  State<ColorsSelectionWidget> createState() => _ColorsSelectionWidgetState();
}

class _ColorsSelectionWidgetState extends State<ColorsSelectionWidget> {
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color', style: widget.theme.textTheme.titleLarge),
        const VerticalSpace(height: AppSizes.sm),
        Row(
          children: List.generate(colors.length, (i) {
            final sel = i == _selectedColor;
            return GestureDetector(
              onTap: () => setState(() => _selectedColor = i),
              child: Padding(
                padding: const EdgeInsets.only(right: AppSizes.sm),
                child: Stack(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: colors[i],
                        shape: BoxShape.circle,
                        border: sel
                            ? Border.all(
                                color: AppColors.dashboardAppbarBackground,
                                width: 2,
                              )
                            : null,
                      ),
                    ),
                    if (sel)
                      const Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Icon(
                          Icons.check,
                          size: AppSizes.iconMd,
                          color: AppColors.white,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
