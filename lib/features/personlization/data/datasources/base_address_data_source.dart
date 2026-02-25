import 'package:ecommerce_app/features/personlization/data/models/address_model.dart';

abstract class BaseAddressDataSource {
  Future<List<AddressModel>> fetchUserAddresses();
  Future<void> addAddress(AddressModel address);
  Future<void> setPrimaryAddress(String addressId);
}

