import 'package:ecommerce_app/core/di/service_locator.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/images/rounded_images.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/features/shop/modules/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/controller/cubit/category_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/products/presentation/controller/cubit/product_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/subCategory/presentation/widget/sub_category_products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategory extends StatelessWidget {
  const SubCategory({super.key, required this.subCategory});
  static const String routeName = '/subCategory';
  final CategoryEntity subCategory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductCubit>(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            subCategory.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const RoundedImage(imageUrl: AppImages.promoBanner1),
                const VerticalSpace(height: AppSizes.spaceBtwSections),

                BlocBuilder<CategoryCubit, CategoryState>(
                  builder: (context, state) {
                    if (state.status == CategoryStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.subCategories.isEmpty) {
                      return const Center(
                        child: Text("No sub categories found"),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.subCategories.length,
                      separatorBuilder: (_, __) => const VerticalSpace(
                        height: AppSizes.spaceBtwSections,
                      ),
                      itemBuilder: (context, index) {
                        final subCat = state.subCategories[index];
                        return Column(
                          children: [
                            SectionHeading(
                              title: subCat.name,
                              buttonTitle: "View all",
                              showActionButton: true,
                              onPressed: () {},
                            ),
                            const VerticalSpace(
                              height: AppSizes.spaceBtwItems / 2,
                            ),
                            SubCategoryProductsList(subCategory: subCat),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
