import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_attribute_model.dart';
import 'package:flutter/material.dart';

class ColorsSelectionWidget extends StatelessWidget {
  const ColorsSelectionWidget({
    super.key,
    required this.theme,
    required this.productAttributes,
    this.selectedColor,
    this.onSelected,
  });

  final ThemeData theme;
  final List<ProductAttributeModel>? productAttributes;
  final String? selectedColor;
  final ValueChanged<String>? onSelected;

  /// Map common color name strings to Flutter Color values
  static final Map<String, Color> _colorMap = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'black': Colors.black,
    'white': Colors.white,
    'yellow': Colors.yellow,
    'orange': Colors.orange,
    'purple': Colors.purple,
    'pink': Colors.pink,
    'brown': Colors.brown,
    'grey': Colors.grey,
    'gray': Colors.grey,
    'teal': Colors.teal,
    'cyan': Colors.cyan,
    'indigo': Colors.indigo,
    'amber': Colors.amber,
    'lime': Colors.lime,
  };

  Color _getColor(String name) => _colorMap[name.toLowerCase()] ?? Colors.grey;

  @override
  Widget build(BuildContext context) {
    if (productAttributes == null) return const SizedBox.shrink();

    final colorAttr = productAttributes!.firstWhere(
      (attr) => attr.name?.toLowerCase() == 'color',
      orElse: () => ProductAttributeModel.empty(),
    );
    final colorNames = colorAttr.values ?? [];

    if (colorNames.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color', style: theme.textTheme.titleLarge),
        const VerticalSpace(height: AppSizes.sm),
        Row(
          children: List.generate(colorNames.length, (i) {
            final colorName = colorNames[i];
            final isSelected = colorName == selectedColor;

            return GestureDetector(
              onTap: () => onSelected?.call(colorName),
              child: Padding(
                padding: const EdgeInsets.only(right: AppSizes.sm),
                child: Stack(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: _getColor(colorName),
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(
                                color: AppColors.dashboardAppbarBackground,
                                width: 2,
                              )
                            : null,
                      ),
                    ),
                    if (isSelected)
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
