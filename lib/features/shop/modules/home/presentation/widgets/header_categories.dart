import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/image_text/image_text_vertical.dart';
import 'package:ecommerce_app/core/utils/popups/loaders.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/core/widgets/shimmers/category_shimmer.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/controller/cubit/category_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/subCategory/presentation/page/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderCategories extends StatelessWidget {
  const HeaderCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state.status == CategoryStatus.error) {
          AppLoaders.errorSnackBar(
            title: 'Oh Snap!',
            message: state.error ?? 'Something went wrong',
            context: context,
          );
        } else if (state.status == CategoryStatus.success &&
            state.featuredCategories.isEmpty) {
          AppLoaders.errorSnackBar(
            title: "No Categories Found",
            context: context,
          );
        }
      },
      builder: (context, state) {
        if (state.status == CategoryStatus.loading) {
          return const CategoryShimmer();
        }
        if (state.status == CategoryStatus.error ||
            state.featuredCategories.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// -- Heading
            const SectionHeading(
              title: AppTextStrings.popularCategories,
              textColor: Colors.white,
              showActionButton: false,
            ),
            const VerticalSpace(height: AppSizes.spaceBtwItems),

            /// -- Categories
            SizedBox(
              height: AppSizes.imageThumbSize,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.featuredCategories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  final category = state.featuredCategories[index];
                  return VerticalImageAndText(
                    image: category.image,
                    title: category.name,

                    onTap: () {
                      AppHelperFunctions.navigateToScreen(
                        context,
                        const SubCategory(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
