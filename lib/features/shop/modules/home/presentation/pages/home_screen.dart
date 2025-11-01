import 'package:ecommerce_app/core/layout/grid_layout.dart';
import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:ecommerce_app/core/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/features/shop/modules/all_product/presentation/page/all_product_screen.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/header_categories.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/home_app_bar.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/product_card_vertical.dart';
import 'package:ecommerce_app/features/shop/modules/home/presentation/widgets/promoSlider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double currentIndex = 0;
  TextEditingController? searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: RoundedContainer(
                child: Container(
                  width: double.infinity,
                  height: AppHelperFunctions.screenHeight(context) * 0.4,
                  padding: EdgeInsets.only(
                    top: AppHelperFunctions.getTopSafeArea(context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeAppBar(),
                      const VerticalSpace(height: AppSizes.spaceBtwSections),
                      MyTextFormField(
                        hintText: AppTextStrings.tDashboardSearch,
                        isObsecure: false,
                        controller: searchController!,
                        prefixIcon: const Icon(Iconsax.search_normal),
                      ),
                      const VerticalSpace(height: AppSizes.spaceBtwSections),
                      const HeaderCategories(),
                    ],
                  ),
                ),
              ),
            ),
            const PromoSlider(),
            const VerticalSpace(height: AppSizes.spaceBtwSections),
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: SectionHeading(
                title: AppTextStrings.popularProducts,
                showActionButton: true,
                onPressed: () => AppHelperFunctions.navigateToScreen(
                  context,
                  const AllProductScreen(),
                ),
              ),
            ),
            const VerticalSpace(height: AppSizes.spaceBtwItems),
            Padding(
              padding: const EdgeInsets.all(AppSizes.defaultSpace),
              child: GridLayout(
                itemCount: 10,

                itemBuilder: (context, index) {
                  return const ProductCardVertical();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
