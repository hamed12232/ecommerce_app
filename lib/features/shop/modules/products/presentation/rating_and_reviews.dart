import 'package:ecommerce_app/core/style/spacing/horizental_space.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/widget/rating_progress_row.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/widget/review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

class RatingAndReviews extends StatelessWidget {
  const RatingAndReviews({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = AppHelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? AppColors.dark : AppColors.white,
      appBar: AppBar(
        title: Text(
          " Reviews & Ratings",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ratings and reviews are verified and are from people who use the same type of device that you use.',
              style: theme.textTheme.bodySmall,
            ),

            const VerticalSpace(height: AppSizes.lg),
            // reviews list
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // big rating
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '4.7',
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                    const VerticalSpace(height: AppSizes.spaceBtwSections),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: 3.5,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: AppSizes.iconMd,
                          unratedColor: AppColors.grey,
                          itemBuilder: (context, _) => const Icon(
                            Iconsax.star1,
                            color: AppColors.primary,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                      ],
                    ),
                    Text(' 12,611', style: theme.textTheme.bodySmall),
                  ],
                ),

                const HorizentalSpace(width: AppSizes.lg),

                // bars
                Expanded(
                  child: Column(
                    children: [
                      RatingProgressRow(theme: theme, value: "1"),
                      RatingProgressRow(theme: theme, value: "2"),
                      RatingProgressRow(theme: theme, value: "3"),
                      RatingProgressRow(theme: theme, value: "4"),
                      RatingProgressRow(theme: theme, value: "5"),
                    ],
                  ),
                ),
              ],
            ),

            const VerticalSpace(height: AppSizes.spaceBtwSections),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: 3,
                separatorBuilder: (_, __) =>
                    const VerticalSpace(height: AppSizes.spaceBtwSections),
                itemBuilder: (context, index) {
                  return const ReviewCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
