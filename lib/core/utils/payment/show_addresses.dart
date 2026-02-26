import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/popups/loaders.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/address_cubit.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/address_state.dart';
import 'package:ecommerce_app/features/personlization/presentation/pages/add_new_address.dart';
import 'package:ecommerce_app/features/personlization/presentation/widget/single_address_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowAddresses {
  /// Opens a bottom sheet to pick an address.
  /// [addressCubit] – the **same** cubit that drives the checkout screen so
  /// the selected address is immediately reflected in [BillingAddressSection].
  static Future<void> selectNewAddress(
    BuildContext context,
    AddressCubit addressCubit,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => BlocProvider.value(
        value: addressCubit,
        child: const _AddressPickerSheet(),
      ),
    );
  }
}

class _AddressPickerSheet extends StatelessWidget {
  const _AddressPickerSheet();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(AppSizes.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              title: 'Select Address',
              showActionButton: false,
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            // Address list
            BlocConsumer<AddressCubit, AddressState>(
              listener: (context, state) {
                if (state.status == AddressStatus.error) {
                  AppLoaders.errorSnackBar(
                    title: state.error!,
                    context: context,
                  );
                }
              },
              builder: (context, state) {
                if (state.status == AddressStatus.loading ||
                    state.status == AddressStatus.initial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.addresses.isEmpty) {
                  return Center(
                    child: Text(
                      'No addresses found',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }
                return Column(
                  children: state.addresses.map((address) {
                    return SingleAddress(
                      address: address,
                      onTap: () {
                        context.read<AddressCubit>().selectAddress(address);
                        Navigator.pop(context); // close the sheet
                      },
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: AppSizes.defaultSpace * 2),

            // Add new address button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AddNewAddressScreen.routeName,
                    arguments: context.read<AddressCubit>(),
                  );
                },
                child: const Text('Add new address'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
