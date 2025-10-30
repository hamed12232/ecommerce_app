import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/rating_and_reviews.dart';
import 'package:ecommerce_app/features/shop/modules/products/widget/bottom_card_widget.dart';
import 'package:ecommerce_app/features/shop/modules/products/widget/circular_product_container_image.dart';
import 'package:ecommerce_app/features/shop/modules/products/widget/colors_selection_widget.dart';
import 'package:ecommerce_app/features/shop/modules/products/widget/product_description_details.dart';
import 'package:ecommerce_app/features/shop/modules/products/widget/rating_widget.dart';
import 'package:ecommerce_app/features/shop/modules/products/widget/size_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TCurvedEdgesWidget(
              child: Container(
                color: dark ? AppColors.darkGrey : AppColors.lightContainer,
                child: CircularProductContainerImage(dark: dark),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.defaultSpace,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RatingWidget(theme: theme),
                          const VerticalSpace(height: AppSizes.sm),

                          ProductDescriptionDetails(theme: theme, dark: dark),

                          const VerticalSpace(height: AppSizes.lg),

                          // Color selection
                          ColorsSelectionWidget(theme: theme),

                          const VerticalSpace(height: AppSizes.lg),

                          // Size selection
                          SizeSelectionWidget(theme: theme, dark: dark),

                          const VerticalSpace(height: AppSizes.lg * 1.5),
                          SizedBox(
                            width: AppHelperFunctions.screenWidth(context),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.dashboardAppbarBackground,
                                side: const BorderSide(
                                  color: AppColors.dashboardAppbarBackground,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    AppSizes.borderRadiusLg,
                                  ),
                                ),
                              ),
                              child: const Text('Checkout'),
                            ),
                          ),
                          const SizedBox(height: AppSizes.spaceBtwSections),

                          /// - Description
                          const SectionHeading(
                            title: 'Description',
                            showActionButton: false,
                          ),
                          const SizedBox(height: AppSizes.spaceBtwItems),
                          // Read more package
                          // ReadMoreText(
                          //   product.description!,
                          //   trimLines: 2,
                          //   colorClickableText: Colors.pink,
                          //   trimMode: TrimMode.Line,
                          //   trimCollapsedText: ' Show more',
                          //   trimExpandedText: ' Less',
                          //   moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                          //   lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                          // ),
                          const SizedBox(height: AppSizes.spaceBtwSections),

                          /// - Reviews
                          const Divider(),
                          const SizedBox(height: AppSizes.spaceBtwItems),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SectionHeading(
                                title: 'Reviews (199)',
                                showActionButton: false,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Iconsax.arrow_right_3,
                                  size: 18,
                                ),
                                onPressed: () {
                                  Navigator.of( context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const RatingAndReviews(),
                                  ));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom action bar
          ],
        ),
        bottomNavigationBar: BottomCardWidget(theme: theme, dark: dark),
      ),
    );
  }
}
