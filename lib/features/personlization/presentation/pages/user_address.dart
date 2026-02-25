import 'package:ecommerce_app/core/utils/constant/colors.dart';
import 'package:ecommerce_app/core/utils/constant/sizes.dart';
import 'package:ecommerce_app/core/utils/popups/loaders.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/address_cubit.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/address_state.dart';
import 'package:ecommerce_app/features/personlization/presentation/pages/add_new_address.dart';
import 'package:ecommerce_app/features/personlization/presentation/widget/single_address_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class UserAddress extends StatelessWidget {
  const UserAddress({super.key});

  static const String routeName = '/user_address';

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
        child: BlocConsumer<AddressCubit, AddressState>(
          listener: (context, state) {
            if (state.status == AddressStatus.error) {
              AppLoaders.errorSnackBar(title: state.error!, context: context);
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
            return ListView.builder(
              itemCount: state.addresses.length,
              itemBuilder: (context, index) {
                final address = state.addresses[index];
                return SingleAddress(
                  address: address,
                  onTap: () =>
                      context.read<AddressCubit>().selectAddress(address),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Iconsax.add, color: AppColors.white),
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddNewAddressScreen.routeName,
            arguments: context.read<AddressCubit>(),
          );
        },
      ),
    );
  }
}
