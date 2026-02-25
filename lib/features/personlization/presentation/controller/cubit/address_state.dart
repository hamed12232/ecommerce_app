
import 'package:ecommerce_app/features/personlization/data/models/address_model.dart';

enum AddressStatus { initial, loading, success, error }
enum AddAddressStatus { initial, loading, success, error }

class AddressState {
  const AddressState({
    this.status = AddressStatus.initial,
    this.addAddressStatus = AddAddressStatus.initial,
    this.addresses = const [],
    this.selectedAddress,
    this.error,
  });

  final AddressStatus status;
  final AddAddressStatus addAddressStatus;
  final List<AddressModel> addresses;
  final AddressModel? selectedAddress;
  final String? error;

  AddressState copyWith({
    AddressStatus? status,
    AddAddressStatus? addAddressStatus,
    List<AddressModel>? addresses,
    AddressModel? selectedAddress,
    String? error,
  }) {
    return AddressState(
      status: status ?? this.status,
      addAddressStatus: addAddressStatus ?? this.addAddressStatus,
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      error: error ?? this.error,
    );
  }
}

