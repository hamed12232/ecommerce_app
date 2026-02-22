import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/icons/circular_icons.dart';
import 'package:ecommerce_app/features/shop/modules/favourites/presentation/controller/cubit/favourite_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/favourites/presentation/controller/cubit/favourite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteCubit, FavouriteState>(
      builder: (context, state) {
        final isFavourite = state.favouriteIds.contains(productId);
        return CircularIcon(
          icon: isFavourite ? Iconsax.heart5 : Iconsax.heart,
          color: isFavourite ? AppColors.red : null,
          onPressed: () =>
              context.read<FavouriteCubit>().toggleFavourite(productId),
        );
      },
    );
  }
}
