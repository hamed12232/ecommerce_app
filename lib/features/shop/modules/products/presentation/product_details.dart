import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/enums.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:ecommerce_app/features/shop/modules/products/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/controller/cubit/product_variation_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/controller/cubit/product_variation_state.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/rating_and_reviews.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/widget/bottom_card_widget.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/widget/circular_product_container_image.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/widget/colors_selection_widget.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/widget/product_description_details.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/widget/rating_widget.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/widget/selected_variation_container.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/widget/size_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});
  static const String routeName = '/product-details';
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    final theme = Theme.of(context);

    // Check if product is variable
    final isVariableProduct =
        product.productType == ProductType.variable.toString();

    return BlocProvider(
      create: (context) => ProductVariationCubit(product: product),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                TCurvedEdgesWidget(
                  child: Container(
                    color: dark ? AppColors.darkGrey : AppColors.lightContainer,
                    child:
                        BlocBuilder<
                          ProductVariationCubit,
                          ProductVariationState
                        >(
                          buildWhen: (previous, current) =>
                              previous.selectedVariation !=
                                  current.selectedVariation &&
                              previous.currentImage != current.currentImage,
                          builder: (context, state) {
                            return CircularProductContainerImage(
                              dark: dark,
                              thumbnail: product.thumbnail,
                              images: product.images,
                              variationImage:
                                  state.currentImage != product.thumbnail
                                  ? state.currentImage
                                  : null,
                            );
                          },
                        ),
                  ),
                ),
                Column(
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
                
                          /// -- Price, Title, Stock, SKU, Brand
                          ProductDescriptionDetails(
                            theme: theme,
                            dark: dark,
                            product: product,
                          ),
                
                          const VerticalSpace(height: AppSizes.lg),
                
                          /// -- Attributes & Variation Details (Only for Variable Products)
                          if (isVariableProduct) ...[
                            BlocBuilder<
                              ProductVariationCubit,
                              ProductVariationState
                            >(
                              builder: (context, state) {
                                return SelectedVariationContainer(
                                  theme: theme,
                                  dark: dark,
                                  state: state,
                                );
                              },
                            ),
                            const VerticalSpace(height: AppSizes.lg),
                
                            /// -- Color selection
                            BlocBuilder<
                              ProductVariationCubit,
                              ProductVariationState
                            >(
                              buildWhen: (previous, current) =>
                                  previous.selectedColor !=
                                  current.selectedColor,
                              builder: (context, state) {
                                return ColorsSelectionWidget(
                                  theme: theme,
                                  productAttributes:
                                      product.productAttributes,
                                  selectedColor: state.selectedColor,
                                  onSelected: (color) {
                                    context
                                        .read<ProductVariationCubit>()
                                        .selectColor(color);
                                  },
                                );
                              },
                            ),
                            const VerticalSpace(height: AppSizes.lg),
                
                            /// -- Size selection
                            BlocBuilder<
                              ProductVariationCubit,
                              ProductVariationState
                            >(
                              buildWhen: (previous, current) =>
                                  previous.selectedSize !=
                                  current.selectedSize,
                              builder: (context, state) {
                                return SizeSelectionWidget(
                                  theme: theme,
                                  dark: dark,
                                  productAttributes:
                                      product.productAttributes,
                                  selectedSize: state.selectedSize,
                                  onSelected: (size) {
                                    context
                                        .read<ProductVariationCubit>()
                                        .selectSize(size);
                                  },
                                );
                              },
                            ),
                            const VerticalSpace(height: AppSizes.lg * 1.5),
                          ],
                
                          SizedBox(
                            width: AppHelperFunctions.screenWidth(context),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.dashboardAppbarBackground,
                                side: const BorderSide(
                                  color:
                                      AppColors.dashboardAppbarBackground,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusGeometry.circular(
                                        AppSizes.borderRadiusLg,
                                      ),
                                ),
                              ),
                              child: const Text('Checkout'),
                            ),
                          ),
                          const SizedBox(height: AppSizes.spaceBtwSections),
                
                          /// -- Description
                          const SectionHeading(
                            title: 'Description',
                            showActionButton: false,
                          ),
                          const SizedBox(height: AppSizes.spaceBtwItems),
                          if (product.description != null &&
                              product.description!.isNotEmpty)
                            Text(
                              product.description!,
                              style: theme.textTheme.bodyMedium,
                            ),
                          const SizedBox(height: AppSizes.spaceBtwSections),
                
                          /// -- Reviews
                          const Divider(),
                          const SizedBox(height: AppSizes.spaceBtwItems),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
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
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RatingAndReviews(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomCardWidget(theme: theme, dark: dark),
        ),
      ),
    );
  }
}
