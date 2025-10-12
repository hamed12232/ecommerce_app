import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/categories.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/constant/text_strings.dart';
import 'package:ecommerce_app/core/utils/image_text/image_text_vertical.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:flutter/material.dart';

class HeaderCategories extends StatelessWidget {
  const HeaderCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// -- Heading
        const SectionHeading(
          title: AppTextStrings.popularProducts,
          textColor: Colors.white,
          showActionButton: false,
        ),
        const VerticalSpace(height: AppSizes.spaceBtwItems),
    
        /// -- Categories
        SizedBox(
          height: AppSizes.imageThumbSize,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: (categories["titles"] as List<String>).length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final categoryImages = categories["images"] as List<String>;
              final categoryTitles = categories["titles"] as List<String>;
    
              return VerticalImageAndText(
                image: categoryImages[index],
                title: categoryTitles[index],
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}
