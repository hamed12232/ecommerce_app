import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/payment/show_addresses.dart';
import 'package:ecommerce_app/core/utils/text/section_heading.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/address_cubit.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        final address = state.selectedAddress;

        final name = address?.name ?? 'No address selected';
        final phone = address?.phoneNumber ?? '';
        final fullAddress = address?.toString() ?? '';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeading(
              title: 'Shipping Address',
              buttonTitle: 'Change',
              showActionButton: true,
              onPressed: () {
                ShowAddresses.selectNewAddress(
                  context,
                  context.read<AddressCubit>(),
                );
              },
            ),
            Text(name, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: AppSizes.spaceBtwItems / 2),
            if (phone.isNotEmpty)
              Row(
                children: [
                  const Icon(Icons.phone, color: Colors.grey, size: 16),
                  const SizedBox(width: AppSizes.spaceBtwItems),
                  Text(phone, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            const SizedBox(height: AppSizes.spaceBtwItems / 2),
            if (fullAddress.isNotEmpty)
              Row(
                children: [
                  const Icon(
                    Icons.location_history,
                    color: Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: AppSizes.spaceBtwItems),
                  Expanded(
                    child: Text(
                      fullAddress,
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
