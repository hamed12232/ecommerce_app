import 'package:ecommerce_app/core/layout/grid_layout.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/features/shop/modules/favourites/presentation/controller/cubit/favourite_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/favourites/presentation/controller/cubit/favourite_state.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/product_card_vertical.dart';
import 'package:ecommerce_app/features/shop/modules/wishlist/presentation/widgets/wishlist_section_heading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  static const String routeName = '/wishlist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: AppSizes.appBarHeight,
          left: AppSizes.defaultSpace,
          right: AppSizes.defaultSpace,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const WishlistSectionHeading(
                title: AppTextStrings.wishlistAppBar,
              ),
              const VerticalSpace(height: AppSizes.spaceBtwInputFields),
              BlocBuilder<FavouriteCubit, FavouriteState>(
                builder: (context, state) {
                  if (state is FavouriteLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is FavouriteLoaded) {
                    if (state.products.isEmpty) {
                      return const Center(
                        child: Text('Your wishlist is empty.'),
                      );
                    }
                    return GridLayout(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        return ProductCardVertical(
                          product: state.products[index],
                        );
                      },
                    );
                  }
                  if (state is FavouriteError) {
                    return Center(child: Text(state.message));
                  }

                  // Initial or Updated state (where products are not loaded yet)
                  // We trigger a fetch if we are in this screen
                  context.read<FavouriteCubit>().fetchFavouriteProducts();
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
