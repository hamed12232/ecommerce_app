import 'package:ecommerce_app/core/layout/grid_layout.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/widget/feature_brand.dart';
import 'package:ecommerce_app/features/shop/modules/store/presentation/widget/store_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = AppHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: AppHelperFunctions.isDarkMode(context)
                  ? Colors.black
                  : Colors.white,
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              expandedHeight: 440,

              flexibleSpace: Padding(
                padding: const EdgeInsets.all(AppSizes.defaultSpace),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const StoreAppBar(),
                    const VerticalSpace(height: AppSizes.spaceBtwSections),
                    MyTextFormField(
                      hintText: AppTextStrings.tDashboardSearch,
                      isObsecure: false,
                      controller: searchController,
                      prefixIcon: const Icon(Iconsax.search_normal),
                    ),
                    const VerticalSpace(height: AppSizes.spaceBtwSections),
                    const SectionHeading(
                      title: AppTextStrings.storeScreenFeaturedBrands,
                    ),
                    const VerticalSpace(height: AppSizes.spaceBtwItems / 1.5),
                    GridLayout(
                      itemCount: 10,
                      mainAxisExtent: 100,
                      itemBuilder: (context, index) {
                        return FeaturedBrand(isDark: isDark);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Container(),
      ),
    );
  }
}
