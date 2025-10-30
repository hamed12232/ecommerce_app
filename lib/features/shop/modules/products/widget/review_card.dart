import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = AppHelperFunctions.isDarkMode(context);

    return Container(
      color: dark ? AppColors.dark : AppColors.lightBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(
                  AppImages.userProfileImage,
                ), // ضع صورتك هنا
              ),
              const SizedBox(width: 10),
              Text(
                "John Doe",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const Icon(Icons.more_vert),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            children: [
              RatingBar.builder(
                initialRating: 4,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 18,
                unratedColor: AppColors.grey,
                itemBuilder: (context, _) =>
                    const Icon(Iconsax.star1, color: AppColors.primary),
                onRatingUpdate: (_) {},
              ),
              const SizedBox(width: 10),
              Text("01-Nov-2023", style: theme.textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 8),

          /// --- User Review Text ---
          Text(
            "The user interface of the app is quite intuitive. "
            "I was able to navigate and make purchases seamlessly. Great job!",
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),

          /// --- Store Reply ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: dark?AppColors.grey.withOpacity(0.2):AppColors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// --- Store name + date ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "T Store",
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text("01-Nov-2023", style: theme.textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(height: 6),
                const ReadMoreText(
                  'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' show more',
                  trimExpandedText: ' show less',
                  moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  lessStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
