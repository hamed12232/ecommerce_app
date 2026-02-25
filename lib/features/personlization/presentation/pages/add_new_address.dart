import 'package:ecommerce_app/core/utils/constant/image_strings.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/popups/full_screen_loader.dart';
import 'package:ecommerce_app/core/utils/popups/loaders.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/features/personlization/data/models/address_model.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/address_cubit.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});
  static const String routeName = "Add_address";

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _postalController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _postalController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) return;

    final address = AddressModel(
      id: '',
      name: _nameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      street: _streetController.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim(),
      postalCode: _postalController.text.trim(),
      country: _countryController.text.trim(),
      date: DateTime.now(),
      selectedAddress: false,
    );

    await context.read<AddressCubit>().addNewAddress(address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add new Address',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyTextFormField(
                hintText: 'Name',
                isObsecure: false,
                controller: _nameController,
                prefixIcon: const Icon(Iconsax.user),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),
              MyTextFormField(
                hintText: 'Phone Number',
                isObsecure: false,
                controller: _phoneController,
                prefixIcon: const Icon(Iconsax.call),
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyTextFormField(
                      hintText: 'Street',
                      isObsecure: false,
                      controller: _streetController,
                      prefixIcon: const Icon(Iconsax.building),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MyTextFormField(
                      hintText: 'Postal Code',
                      isObsecure: false,
                      controller: _postalController,
                      prefixIcon: const Icon(Iconsax.code),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyTextFormField(
                      hintText: 'City',
                      isObsecure: false,
                      controller: _cityController,
                      prefixIcon: const Icon(Iconsax.location),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: MyTextFormField(
                      hintText: 'State',
                      isObsecure: false,
                      controller: _stateController,
                      prefixIcon: const Icon(Iconsax.flag),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwInputFields),
              MyTextFormField(
                hintText: 'Country',
                isObsecure: false,
                controller: _countryController,
                prefixIcon: const Icon(Iconsax.global),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              BlocListener<AddressCubit, AddressState>(
                listener: (context, state) {
                  if (state.addAddressStatus == AddAddressStatus.loading) {
                    AppFullScreenLoader.openLoadingDialog(
                      'Adding address...',
                      AppImages.docerAnimation,
                      context,
                    );
                  } else if (state.addAddressStatus ==
                      AddAddressStatus.success) {
                    AppFullScreenLoader.stopLoading(context);
                    AppLoaders.successSnackBar(
                      title: 'Address added successfully',
                      context: context,
                    );
                    Navigator.of(context).pop();
                  } else if (state.addAddressStatus == AddAddressStatus.error) {
                    AppFullScreenLoader.stopLoading(context);
                    AppLoaders.errorSnackBar(
                      title: state.error!,
                      context: context,
                    );
                  }
                },

                child: CustomButton(text: 'Save', onPressed: _saveAddress),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
