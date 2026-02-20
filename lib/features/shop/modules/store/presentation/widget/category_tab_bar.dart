import 'package:ecommerce_app/core/layout/grid_layout.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/core/widgets/shimmers/boxes_shimmer.dart';
import 'package:ecommerce_app/core/widgets/shimmers/list_tile_shimmer.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/presentation/page/all_product_screen.dart';
import 'package:ecommerce_app/features/shop/modules/brand/presentation/controller/cubit/brand_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/product_card_vertical.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/controller/cubit/product_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/controller/cubit/product_state.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/widget/brand_show_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTabBar extends StatefulWidget {
  const CategoryTabBar({super.key, required this.category});
  final CategoryEntity category;

  @override
  State<CategoryTabBar> createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<CategoryTabBar> {
  @override
  void initState() {
    super.initState();
    context.read<BrandCubit>().fetchBrandsForCategory(widget.category.id);
    context.read<ProductCubit>().fetchProductsForCategory(widget.category.id);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              BlocBuilder<BrandCubit, BrandState>(
                builder: (context, state) {
                  final categoryBrands =
                      state.categoryBrands[widget.category.id];
                  if (categoryBrands == null) {
                    return const Column(
                      children: [
                        TListTileShimmer(),
                        SizedBox(height: AppSizes.spaceBtwItems),
                        TBoxesShimmer(),
                      ],
                    );
                  }

                  /// No brands found
                  if (categoryBrands.isEmpty) {
                    return Center(
                      child: Text(
                        'No Brands Found!',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.apply(color: Colors.white),
                      ),
                    );
                  }

                  /// Brands list
                  return Column(
                    children: categoryBrands
                        .map(
                          (brand) =>
                              BrandShowCase(brand: brand, images: const []),
                        )
                        .toList(),
                  );
                },
              ),

              const VerticalSpace(height: AppSizes.spaceBtwInputFields * 2),
              SectionHeading(
                title: AppTextStrings.storeScreenYouMightLike,
                onPressed: () =>
                    Navigator.pushNamed(context, AllProductScreen.routeName),
              ),
              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  final categoryProducts =
                      state.categoryProducts[widget.category.id];

                  /// Loading
                  if (categoryProducts == null) {
                    return const TBoxesShimmer();
                  }

                  /// No products found
                  if (categoryProducts.isEmpty) {
                    return Center(
                      child: Text(
                        'No Products Found!',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.apply(color: Colors.white),
                      ),
                    );
                  }

                  /// Products grid
                  return GridLayout(
                    itemCount: categoryProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCardVertical(
                        product: categoryProducts[index],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
