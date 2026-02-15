import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_app/features/shop/modules/products/data/model/product_attribute_model.dart';
import 'package:flutter/material.dart';

class SizeSelectionWidget extends StatelessWidget {
  const SizeSelectionWidget({
    super.key,
    required this.theme,
    required this.dark,
    required this.productAttributes,
    this.selectedSize,
    this.onSelected,
  });

  final ThemeData theme;
  final bool dark;
  final List<ProductAttributeModel>? productAttributes;
  final String? selectedSize;
  final ValueChanged<String>? onSelected;

  @override
  Widget build(BuildContext context) {
    if (productAttributes == null) return const SizedBox.shrink();

    final sizeAttr = productAttributes!.firstWhere(
      (attr) => attr.name?.toLowerCase() == 'size',
      orElse: () => ProductAttributeModel.empty(),
    );
    final sizes = sizeAttr.values ?? [];

    if (sizes.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Size', style: theme.textTheme.titleLarge),
        const VerticalSpace(height: AppSizes.sm),
        Row(
          children: List.generate(sizes.length, (i) {
            final sizeVal = sizes[i];
            final isSelected = sizeVal == selectedSize;

            return GestureDetector(
              onTap: () => onSelected?.call(sizeVal),
              child: Padding(
                padding: const EdgeInsets.only(right: AppSizes.sm),
                child: RoundedContainer(
                  width: 90,
                  height: 50,
                  showBorder: !isSelected,
                  borderColor: AppColors.darkGrey,
                  radius: AppSizes.cardRadiusMd,
                  backgroundColor: isSelected
                      ? AppColors.dashboardAppbarBackground
                      : (dark ? AppColors.dark : AppColors.white),
                  child: Row(
                    mainAxisAlignment: isSelected
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    children: [
                      if (isSelected)
                        const Icon(
                          Icons.check,
                          size: AppSizes.iconSm,
                          color: AppColors.white,
                        ),
                      Center(
                        child: Text(
                          sizeVal,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: isSelected ? AppColors.white : null,
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
