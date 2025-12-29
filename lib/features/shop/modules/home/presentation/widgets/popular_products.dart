import 'package:ecommerce_app/core/layout/grid_layout.dart';
import 'package:ecommerce_app/core/widgets/shimmers/vertical_product_shimmer.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/product_card_vertical.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/controller/cubit/product_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/controller/cubit/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state.status == ProductStatus.loading) {
          return const VerticalProductShimmer();
        }

        if (state.status == ProductStatus.error) {
          return Center(child: Text(state.error));
        }

        if (state.featuredProducts.isEmpty) {
          return Center(
            child: Text(
              'No Data Found',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }

        return GridLayout(
          itemCount: state.featuredProducts.length,
          itemBuilder: (_, index) =>
              ProductCardVertical(product: state.featuredProducts[index]),
        );
      },
    );
  }
}
