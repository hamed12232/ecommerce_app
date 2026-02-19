import 'package:ecommerce_app/core/di/service_locator.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/appBar/tab_bar.dart';
import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/popups/loaders.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/features/shop/modules/brand/presentation/controller/cubit/brand_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/brand/presentation/page/all_brands.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/controller/cubit/category_cubit.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/widget/brand_feature_bloc_builder.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/widget/category_tab_bar.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/widget/store_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  static const String routeName = '/store';

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    return BlocProvider(
      create: (context) => getIt<BrandCubit>()..fetchBrands(),
      child: BlocConsumer<CategoryCubit, CategoryState>(
        buildWhen: (previous, current) =>
            current.status == CategoryStatus.success,
        listener: (context, state) {
          if (state.status == CategoryStatus.error) {
            AppLoaders.errorSnackBar(
              title: 'Oh Snap!',
              message: state.error ?? 'Something went wrong',
              context: context,
            );
          }
        },
        builder: (context, state) {
          return DefaultTabController(
            length: state.categories.length,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: AppHelperFunctions.isDarkMode(context)
                          ? AppColors.dark
                          : Colors.white,
                      automaticallyImplyLeading: false,
                      pinned: true,
                      floating: true,
                      expandedHeight:
                          AppHelperFunctions.screenHeight(context) * 0.55,

                      flexibleSpace: Padding(
                        padding: const EdgeInsets.all(AppSizes.defaultSpace),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            const StoreAppBar(),
                            const VerticalSpace(
                              height: AppSizes.spaceBtwSections,
                            ),
                            MyTextFormField(
                              hintText: AppTextStrings.tDashboardSearch,
                              isObsecure: false,
                              controller: TextEditingController(),
                              prefixIcon: const Icon(Iconsax.search_normal),
                            ),
                            const VerticalSpace(
                              height: AppSizes.spaceBtwSections,
                            ),
                            SectionHeading(
                              title: AppTextStrings.storeScreenFeaturedBrands,
                              onPressed: () => Navigator.pushNamed(
                                context,
                                AllBrands.routeName,
                              ),
                            ),
                            const VerticalSpace(
                              height: AppSizes.spaceBtwItems / 1.5,
                            ),
                            BrandFeaturedBlocBuilder(isDark: isDark),
                            const VerticalSpace(
                              height: AppSizes.spaceBtwSections,
                            ),
                          ],
                        ),
                      ),
                      bottom: TabBarWidget(
                        tabs: state.categories
                            .map((e) => Tab(text: e.name))
                            .toList(),
                      ),
                    ),
                  ];
                },

                body: TabBarView(
                  children: state.categories
                      .map((category) => CategoryTabBar(category: category))
                      .toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
