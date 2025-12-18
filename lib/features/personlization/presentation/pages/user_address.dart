import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/dummy_data.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/features/personlization/presentation/pages/add_new_address.dart';
import 'package:ecommerce_app/features/personlization/presentation/widget/single_address_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UserAddress extends StatefulWidget {
  const UserAddress({super.key});

  static const String routeName = '/user_address';

  @override
  State<UserAddress> createState() => _UserAddressState();
}

class _UserAddressState extends State<UserAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Addresses",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) =>
              SingleAddress(address: TDummyData.addresses[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Iconsax.add, color: AppColors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewAddressScreen(),
            ),
          );
        },
      ),
    );
  }
}
