import 'package:ecommerce_app/features/personlization/data/models/address_model.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/add_address_usecase.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/get_user_addresses_usecase.dart';
import 'package:ecommerce_app/features/personlization/domain/usecases/set_primary_address_usecase.dart';
import 'package:ecommerce_app/features/personlization/presentation/controller/cubit/address_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit({
    required this.getUserAddressesUseCase,
    required this.addAddressUseCase,
    required this.setPrimaryAddressUseCase,
  }) : super(const AddressState());

  final GetUserAddressesUseCase getUserAddressesUseCase;
  final AddAddressUseCase addAddressUseCase;
  final SetPrimaryAddressUseCase setPrimaryAddressUseCase;

  Future<void> loadUserAddresses() async {
    emit(state.copyWith(status: AddressStatus.loading));

    final result = await getUserAddressesUseCase();
    result.fold(
      (failure) => emit(
        state.copyWith(status: AddressStatus.error, error: failure.message),
      ),
      (addresses) {
        AddressModel? selected;
        if (addresses.isNotEmpty) {
          selected = addresses.firstWhere(
            (element) => element.selectedAddress,
            orElse: () => addresses.first,
          );
        }

        emit(
          state.copyWith(
            status: AddressStatus.success,
            addresses: addresses,
            selectedAddress: selected,
          ),
        );
      },
    );
  }

  Future<void> addNewAddress(AddressModel address) async {
    emit(state.copyWith(addAddressStatus: AddAddressStatus.loading));

    final result = await addAddressUseCase(address);
    result.fold(
      (failure) => emit(
        state.copyWith(
          addAddressStatus: AddAddressStatus.error,
          error: failure.message,
        ),
      ),
      (_) async {
        emit(state.copyWith(addAddressStatus: AddAddressStatus.success));
        emit(state.copyWith(addAddressStatus: AddAddressStatus.initial));
        await loadUserAddresses();
      },
    );
  }

  Future<void> selectAddress(AddressModel address) async {
    final preAddresses = state.addresses;
    final preSelectedAddress = state.selectedAddress;
    final updatedAddress = preAddresses.map((e) {
      return AddressModel(
        id: e.id,
        name: e.name,
        phoneNumber: e.phoneNumber,
        street: e.street,
        city: e.city,
        state: e.state,
        postalCode: e.postalCode,
        country: e.country,
        selectedAddress: e.id == address.id,
      );
    }).toList();
    emit(state.copyWith(addresses: updatedAddress, selectedAddress: address));
    final result = await setPrimaryAddressUseCase(address.id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AddressStatus.error,
          error: failure.message,
          addresses: preAddresses,
          selectedAddress: preSelectedAddress,
        ),
      ),
      (_) {},
    );
  }
}
