import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart'; // استخدم مكتبة أيقونات إن احتجت

// المسار اللي فيه الكلاس بتاعك

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final streetController = TextEditingController();
    final postalController = TextEditingController();
    final cityController = TextEditingController();
    final stateController = TextEditingController();
    final countryController = TextEditingController();


    return Scaffold(
      appBar: AppBar(title:  Text("Add new Address",style: Theme.of( context).textTheme.headlineMedium,), centerTitle: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Name
              MyTextFormField(
                hintText: "Name",
                isObsecure: false,
                controller: nameController,
                prefixIcon: const Icon(Iconsax.user),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),

              /// Phone
              MyTextFormField(
                hintText: "Phone Number",
                isObsecure: false,
                controller: phoneController,
                prefixIcon: const Icon(Iconsax.call),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),

              /// Street + Postal Code
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyTextFormField(
                      hintText: "Street",
                      isObsecure: false,
                      controller: streetController,
                      prefixIcon: const Icon(Iconsax.building),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MyTextFormField(
                      hintText: "Postal Code",
                      isObsecure: false,
                      controller: postalController,
                      prefixIcon: const Icon(Iconsax.code),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),

              /// City + State
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyTextFormField(
                      hintText: "City",
                      isObsecure: false,
                      controller: cityController,
                      prefixIcon: const Icon(Iconsax.location),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MyTextFormField(
                      hintText: "State",
                      isObsecure: false,
                      controller: stateController,
                      prefixIcon: const Icon(Iconsax.flag),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),

              /// Country
              MyTextFormField(
                hintText: "Country",
                isObsecure: false,
                controller: countryController,
                prefixIcon: const Icon(Iconsax.global),
              ),

              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Save Button
              CustomButton(text: "Save", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
