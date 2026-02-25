import 'package:ecommerce_app/core/style/spacing/horizental_space.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/widgets/shimmers/horizontal_product_shimmer.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/controller/cubit/product_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/controller/cubit/product_state.dart';
import 'package:ecommerce_app/features/shop/modules/subCategory/presentation/widget/product_card_horizental.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoryProductsList extends StatelessWidget {
  const SubCategoryProductsList({super.key, required this.subCategory});

  final CategoryEntity subCategory;

  @override
  Widget build(BuildContext context) {
    // We assume ProductCubit is provided in the parent context (SubCategory page)
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) =>
          previous.categoryProducts[subCategory.id] !=
              current.categoryProducts[subCategory.id] ||
          previous.status != current.status,
      builder: (context, state) {
        // Trigger fetch if not already loading or loaded
        if (!state.categoryProducts.containsKey(subCategory.id) &&
            state.status != ProductStatus.loading) {
          context.read<ProductCubit>().fetchProductsForCategory(subCategory.id);
        }

        if (state.status == ProductStatus.loading &&
            !state.categoryProducts.containsKey(subCategory.id)) {
          return const HorizontalProductShimmer();
        }

        final products = state.categoryProducts[subCategory.id] ?? [];

        if (products.isEmpty && state.status == ProductStatus.success) {
          return const SizedBox.shrink();
        }

        return SizedBox(
          height: 120,
          child: ListView.separated(
            itemCount: products.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) =>
                ProductCardHorizontal(product: products[index]),
            separatorBuilder: (_, index) =>
                const HorizentalSpace(width: AppSizes.spaceBtwItems),
          ),
        );
      },
    );
  }
}
