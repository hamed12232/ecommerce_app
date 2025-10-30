import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/features/personlization/presentation/pages/add_new_address.dart';
import 'package:ecommerce_app/features/personlization/presentation/widget/single_address_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UserAddress extends StatefulWidget {
  const UserAddress({super.key});

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
      body: const Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          children: [
            SingleAddress(address: "123, Main Street, New York, NY 10001, USA"),
            SingleAddress(address: "123, Main Street, New York, NY 10001, USA"),
            SingleAddress(address: "123, Main Street, New York, NY 10001, USA"),
          ],
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
