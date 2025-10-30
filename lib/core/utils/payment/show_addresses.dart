import 'package:ecommerce_app/core/style/spacing/vertical_space.dart';
import 'package:ecommerce_app/core/utils/constant/dummy_data.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/helper/helper_functions.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/features/personlization/presentation/pages/add_new_address.dart';
import 'package:ecommerce_app/features/personlization/presentation/widget/single_address_widget.dart';
import 'package:flutter/material.dart';

class ShowAddresses {
  static Future<dynamic> selectNewAddress(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(
                title: 'Select Address',
                showActionButton: false,
              ),
              const VerticalSpace(height: AppSizes.spaceBtwSections),
              Column(
                children: TDummyData.addresses
                    .map((address) => SingleAddress(address: address))
                    .toList(),
              ),
              const SizedBox(height: AppSizes.defaultSpace * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    AppHelperFunctions.navigateToScreen(
                      context,
                      const AddNewAddressScreen(),
                    );
                  },
                  child: const Text('Add new address'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
