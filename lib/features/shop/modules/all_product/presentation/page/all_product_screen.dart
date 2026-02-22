import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/presentation/cubit/all_products_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/presentation/cubit/all_products_state.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/presentation/widget/sort_drop_down.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/popular_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  static const String routeName = '/all-products';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Popular Products',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: SortDropdown(
                onChanged: (value) {
                  if (value == null) return;
                  context.read<AllProductsCubit>().sortProducts(value);
                },
              ),
            ),
            const VerticalSpace(height: AppSizes.spaceBtwItems),
            const _ProductsContent(),
          ],
        ),
      ),
    );
  }
}

class _ProductsContent extends StatelessWidget {
  const _ProductsContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllProductsCubit, AllProductsState>(
      buildWhen: (previous, current) => current is AllProductsLoaded,
      builder: (context, state) {
        if (state is AllProductsLoading) {
          return const VerticalProductShimmer();
        }

        if (state is AllProductsError) {
          return Center(child: Text(state.message));
        }

        if (state is AllProductsLoaded) {
          if (state.products.isEmpty) {
            return Center(
              child: Text(
                'No Data Found',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }
          return PopularProducts(products: state.products);
        }

        return const SizedBox();
      },
    );
  }
}
